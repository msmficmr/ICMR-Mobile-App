import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/services/shared_preference_service.dart';
import 'package:mhealth/utils/app_constant.dart';
import 'package:mhealth/utils/app_endpoints.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:uuid/uuid.dart';

class SyncException implements Exception {
  final String message;
  SyncException(this.message);

  @override
  String toString() => message;
}

/// Sync talks to the server through dio rather than the shared [ApiBaseHelper]
/// for two things `package:http` can't give us: per-request timeouts (the http
/// client has none, which is why a stalled upload used to hang the sync dialog
/// forever) and byte-level progress for the UI.
class SyncApiService {
  /// Raw bytes per chunk. Base64 inflates this by ~33% on the wire.
  static const int chunkSize = 256 * 1024;

  static final SyncApiService instance = SyncApiService._();

  final Dio _dio;

  SyncApiService._()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Environment.runningEnv.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(minutes: 2),
            receiveTimeout: const Duration(minutes: 2),
            responseType: ResponseType.plain,
            // Statuses are inspected by hand so a 4xx carries its body to the UI.
            validateStatus: (_) => true,
          ),
        );

  Map<String, String> _headers() {
    String token = "";
    try {
      final raw = SharedPreferencesService.sharedPreferencesService.readData(key: AppConstant.SHARED_PREFERENCE_USER_DETAILS);
      if (raw != null && raw.isNotEmpty) {
        token = (jsonDecode(raw) as Map)['accessToken'] ?? "";
      }
    } catch (e) {
      log("SyncApiService: could not read access token: $e");
    }
    return {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  /// Uploads one image in ordered chunks and returns its GridFS id.
  ///
  /// [onProgress] reports 0..1 for this file. [cancelToken] lets the user stop
  /// a run mid-file.
  Future<String> uploadImage({
    required String filePath,
    required String fileName,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final List<int> bytes;
    try {
      bytes = await CommonFunctions().readFileInIsolate(filePath);
    } catch (e) {
      // The file is gone (cleaned up, or a stale content uri). Surfacing this
      // is the point — the old code swallowed it and shipped the path as if it
      // were image data.
      throw SyncException("Image file could not be read: $fileName");
    }

    if (bytes.isEmpty) {
      throw SyncException("Image file is empty: $fileName");
    }

    final String sessionId = const Uuid().v4();
    final int totalChunks = (bytes.length / chunkSize).ceil();

    final int totalBytes = bytes.length;

    for (int index = 0; index < totalChunks; index++) {
      final int start = index * chunkSize;
      final int end = (start + chunkSize) > totalBytes ? totalBytes : (start + chunkSize);
      final bool isLast = index == totalChunks - 1;
      final int chunkBytes = end - start;

      final Response response = await _dio.post(
        AppEndpoints.uploadImageChunk,
        data: jsonEncode({
          "fileId": sessionId,
          "chunkIndex": index,
          "isLastChunk": isLast,
          "fileName": fileName,
          "data": base64.encode(bytes.sublist(start, end)),
        }),
        options: Options(headers: _headers()),
        cancelToken: cancelToken,
        // Byte-level progress within the chunk request. Map it onto the whole
        // file so the bar advances smoothly instead of jumping per chunk.
        onSendProgress: (sent, total) {
          if (total <= 0) return;
          final double chunkFraction = (sent / total).clamp(0.0, 1.0);
          final double overall = (start + chunkFraction * chunkBytes) / totalBytes;
          // Hold back the last hair until the server confirms the final chunk.
          onProgress?.call(overall.clamp(0.0, 0.999));
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw SyncException("Upload failed for $fileName (HTTP ${response.statusCode})");
      }

      final Map<String, dynamic> body = _decode(response.data);

      if (isLast) {
        final String? gridFsId = body["gridFsId"];
        if (gridFsId == null || gridFsId.isEmpty) {
          throw SyncException("Server did not return an id for $fileName");
        }
        onProgress?.call(1);
        return gridFsId;
      }

      // Chunk accepted: pin progress to the byte boundary we just cleared.
      onProgress?.call((end / totalBytes).clamp(0.0, 0.999));
    }

    throw SyncException("Upload produced no id for $fileName");
  }

  /// Posts the (now small) sync payload. Returns true when the server accepts it.
  Future<bool> postSyncPayload(Map<String, dynamic> payload, {CancelToken? cancelToken}) async {
    final Response response = await _dio.post(
      AppEndpoints.syncData,
      data: jsonEncode(payload),
      options: Options(headers: _headers()),
      cancelToken: cancelToken,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw SyncException("Sync rejected by server (HTTP ${response.statusCode})");
    }

    final Map<String, dynamic> body = _decode(response.data);
    final int status = body["status"] ?? response.statusCode ?? 0;
    if (status != 201 && status != 200) {
      throw SyncException(body["message"]?.toString() ?? "Sync rejected by server");
    }
    return true;
  }

  Map<String, dynamic> _decode(dynamic data) {
    try {
      if (data is Map<String, dynamic>) return data;
      final decoded = jsonDecode(data.toString());
      return decoded is Map<String, dynamic> ? decoded : {};
    } catch (e) {
      return {};
    }
  }
}

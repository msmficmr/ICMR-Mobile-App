import 'dart:developer';
import 'dart:io';

import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';

class LesionImageInfo {
  final String path;
  final String name;
  final DateTime timestamp;
  final int size;

  LesionImageInfo({
    required this.path,
    required this.name,
    required this.timestamp,
    required this.size,
  });
}

class LesionImageCleanupService {
  static const Duration retention = Duration(days: 14);
  static const String _folderName = 'LesionImages';

  // Public path where MediaStore publishes the images on Android.
  static const String _androidPublicDir = '/storage/emulated/0/Pictures/$_folderName';

  static final LesionImageCleanupService instance = LesionImageCleanupService._();
  LesionImageCleanupService._();

  Future<List<LesionImageInfo>> listAllImages() async {
    final dir = await _resolveDir();
    if (dir == null || !await dir.exists()) return const [];

    final entries = <LesionImageInfo>[];
    try {
      await for (final entity in dir.list()) {
        if (entity is! File) continue;
        final name = entity.uri.pathSegments.last;
        final stat = await entity.stat();
        entries.add(LesionImageInfo(
          path: entity.path,
          name: name,
          timestamp: _timestampFromName(name) ?? stat.modified,
          size: stat.size,
        ));
      }
    } catch (e) {
      log('LesionImageCleanupService.list failed: $e');
    }
    return entries;
  }

  Future<Directory?> _resolveDir() async {
    if (Platform.isAndroid) {
      return Directory(_androidPublicDir);
    }
    final base = await getApplicationDocumentsDirectory();
    return Directory('${base.path}/$_folderName');
  }

  // Files are saved as `{patientId}_{epochMillis}_{locationId}_{siteId}_{uuid}.{ext}`.
  // The epoch-millis segment is the second token when split by `_`.
  DateTime? _timestampFromName(String name) {
    final parts = name.split('_');
    for (final part in parts) {
      // 13 digits = a millis-since-epoch timestamp in the 2000s+. Skip short numeric IDs.
      if (part.length >= 12 && part.length <= 14) {
        final n = int.tryParse(part);
        if (n != null && n > 946684800000) {
          // Sanity: after 2000-01-01.
          return DateTime.fromMillisecondsSinceEpoch(n);
        }
      }
    }
    return null;
  }

  List<LesionImageInfo> filterOlderThanRetention(List<LesionImageInfo> files, {DateTime? now}) {
    final cutoff = (now ?? DateTime.now()).subtract(retention);
    return files.where((f) => f.timestamp.isBefore(cutoff)).toList();
  }

  Future<int> deleteFiles(
    List<LesionImageInfo> files, {
    void Function(int done, int total)? onProgress,
  }) async {
    int deleted = 0;
    for (int i = 0; i < files.length; i++) {
      final ok = await _deleteOne(files[i]);
      if (ok) deleted++;
      onProgress?.call(i + 1, files.length);
    }
    return deleted;
  }

  Future<bool> _deleteOne(LesionImageInfo file) async {
    try {
      if (Platform.isAndroid) {
        // Go through MediaStore so it works on API 30+ scoped storage too.
        final ok = await MediaStore().deleteFile(
          fileName: file.name,
          dirType: DirType.photo,
          dirName: DirName.pictures,
        );
        if (ok) return true;
      }
      final f = File(file.path);
      if (await f.exists()) {
        await f.delete();
      }
      return true;
    } catch (e) {
      log('LesionImageCleanupService.delete failed for ${file.path}: $e');
      return false;
    }
  }
}

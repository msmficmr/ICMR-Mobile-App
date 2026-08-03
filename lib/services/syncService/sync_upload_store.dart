import 'dart:convert';
import 'dart:developer';

import 'package:mhealth/services/shared_preference_service.dart';

/// Remembers which local images have already been pushed to GridFS, so a sync
/// that dies half way (app killed, network gone) doesn't re-upload megabytes it
/// already sent. Keyed by the local file path / content uri.
///
/// Entries are dropped only once the case they belong to has been accepted by
/// the server, at which point the local file is deleted too.
class SyncUploadStore {
  static const String _key = "sync_uploaded_image_ids";

  static final SyncUploadStore instance = SyncUploadStore._();
  SyncUploadStore._();

  Map<String, String> _cache = {};
  bool _loaded = false;

  Future<void> load() async {
    if (_loaded) return;
    try {
      final raw = SharedPreferencesService.sharedPreferencesService.readData(key: _key);
      if (raw != null && raw.isNotEmpty) {
        _cache = Map<String, String>.from(jsonDecode(raw) as Map);
      }
    } catch (e) {
      log("SyncUploadStore.load failed: $e");
      _cache = {};
    }
    _loaded = true;
  }

  String? gridFsIdFor(String filePath) => _cache[filePath];

  Future<void> remember(String filePath, String gridFsId) async {
    _cache[filePath] = gridFsId;
    await _persist();
  }

  Future<void> forget(Iterable<String> filePaths) async {
    for (final path in filePaths) {
      _cache.remove(path);
    }
    await _persist();
  }

  Future<void> _persist() async {
    try {
      await SharedPreferencesService.sharedPreferencesService.writeString(key: _key, value: jsonEncode(_cache));
    } catch (e) {
      log("SyncUploadStore.persist failed: $e");
    }
  }
}

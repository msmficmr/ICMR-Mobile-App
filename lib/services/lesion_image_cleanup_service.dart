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
      // Images live in per-patient subfolders: <root>/<primaryId>/.
      await for (final entity in dir.list(recursive: true)) {
        if (entity is! File) continue;
        final name = entity.uri.pathSegments.last;
        final stat = await entity.stat();
        entries.add(LesionImageInfo(
          path: entity.path,
          name: name,
          timestamp: stat.modified,
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

  /// [protectedPrimaryIds] are patients whose data hasn't reached the server
  /// yet. Their images live in LesionImages/<primaryId>/ and must survive the
  /// retention sweep, otherwise a delayed sync has nothing left to upload.
  List<LesionImageInfo> filterOlderThanRetention(
    List<LesionImageInfo> files, {
    DateTime? now,
    Set<String> protectedPrimaryIds = const {},
  }) {
    final cutoff = (now ?? DateTime.now()).subtract(retention);
    return files.where((f) {
      if (!f.timestamp.isBefore(cutoff)) return false;
      return !protectedPrimaryIds.contains(_primaryIdOf(f.path));
    }).toList();
  }

  // .../LesionImages/<primaryId>/<file> -> <primaryId>
  String _primaryIdOf(String path) {
    final segments = path.split('/');
    final index = segments.lastIndexOf(_folderName);
    if (index == -1 || index + 1 >= segments.length - 1) return "";
    return segments[index + 1];
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

  // MediaStore path of the file's folder, relative to Pictures/.
  // /storage/emulated/0/Pictures/LesionImages/P1/2/x.jpg -> LesionImages/P1/2
  String _relativePathOf(String path) {
    const marker = '/Pictures/';
    final at = path.indexOf(marker);
    if (at == -1) return _folderName;

    final segments = path.substring(at + marker.length).split('/')..removeLast();
    return segments.isEmpty ? _folderName : segments.join('/');
  }

  Future<bool> _deleteOne(LesionImageInfo file) async {
    try {
      if (Platform.isAndroid) {
        // Go through MediaStore so it works on API 30+ scoped storage too.
        final ok = await MediaStore().deleteFile(
          fileName: file.name,
          dirType: DirType.photo,
          dirName: DirName.pictures,
          relativePath: _relativePathOf(file.path),
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

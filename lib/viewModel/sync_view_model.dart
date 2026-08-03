import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mhealth/config/environment/environment.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/patient_registration_schema.dart';
import 'package:mhealth/isar_db_schema/questionnaire_db_schema.dart';
import 'package:mhealth/services/isar_db_service.dart';
import 'package:mhealth/services/syncService/sync_api_service.dart';
import 'package:mhealth/services/syncService/sync_upload_store.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';

enum SyncItemStatus { pending, running, done, failed }

/// One image belonging to a case: a lesion capture, a consent scan or a signature.
class SyncImageItem {
  final AttachmentDb attachment;
  final String fileName;
  final String filePath;

  String? gridFsId;
  double progress;
  SyncItemStatus status;
  String? error;

  SyncImageItem({
    required this.attachment,
    required this.fileName,
    required this.filePath,
    this.gridFsId,
    this.progress = 0,
    this.status = SyncItemStatus.pending,
    this.error,
  });
}

/// One unit of work: a patient registration, optionally with a CRA case.
class SyncCaseItem {
  final PatientRegistration patient;
  final CRAOfflineData? craData;
  final List<SyncImageItem> images;

  SyncItemStatus status;
  String? error;

  SyncCaseItem({
    required this.patient,
    required this.craData,
    required this.images,
    this.status = SyncItemStatus.pending,
    this.error,
  });

  String get primaryId => patient.primaryId;
  String get patientId => patient.patientId;
  String? get caseId => craData?.caseId;
  String get label => patient.primaryId;

  int get uploadedImageCount => images.where((i) => i.status == SyncItemStatus.done).length;
}

/// Drives a sync run: every image is uploaded on its own first, then the case
/// payload goes up carrying the returned GridFS ids instead of base64 bytes.
///
/// A case is held back until *all* of its images are uploaded, so a case never
/// reaches the CDR with missing reports. Whatever did upload is remembered in
/// [SyncUploadStore], so a retry resumes rather than starting over.
class SyncViewModel extends ChangeNotifier {
  final PatientListViewModel patientListViewModel;

  SyncViewModel({required this.patientListViewModel});

  final List<SyncCaseItem> _cases = [];
  List<SyncCaseItem> get cases => List.unmodifiable(_cases);

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  bool _hasRun = false;
  bool get hasRun => _hasRun;

  bool _isPreparing = false;
  bool get isPreparing => _isPreparing;

  int _currentCaseIndex = -1;
  int get currentCaseIndex => _currentCaseIndex;

  SyncCaseItem? get currentCase => (_currentCaseIndex >= 0 && _currentCaseIndex < _cases.length) ? _cases[_currentCaseIndex] : null;

  SyncImageItem? _currentImage;
  SyncImageItem? get currentImage => _currentImage;

  CancelToken? _cancelToken;

  int get totalCases => _cases.length;
  int get completedCases => _cases.where((c) => c.status == SyncItemStatus.done).length;
  int get failedCases => _cases.where((c) => c.status == SyncItemStatus.failed).length;

  /// Cases that have never been synced yet (a fresh run or whatever was left
  /// behind after a stop). A [SyncItemStatus.done] case is never in here, so it
  /// is never posted to the CDR a second time.
  int get pendingCases => _cases.where((c) => c.status == SyncItemStatus.pending).length;

  /// True once a run has finished with nothing left to do — everything synced
  /// and no failures. Used to show a completion state instead of a re-sync button.
  bool get allSynced => _hasRun && !_isRunning && totalCases > 0 && failedCases == 0 && pendingCases == 0;

  int get totalImages => _cases.fold(0, (sum, c) => sum + c.images.length);
  int get uploadedImages => _cases.fold(0, (sum, c) => sum + c.uploadedImageCount);
  int get failedImages => _cases.fold(0, (sum, c) => sum + c.images.where((i) => i.status == SyncItemStatus.failed).length);

  List<SyncImageItem> get failedImageItems => _cases.expand((c) => c.images).where((i) => i.status == SyncItemStatus.failed).toList();

  double get overallProgress {
    if (_cases.isEmpty) return 0;
    return completedCases / _cases.length;
  }

  /// Builds the work list from local storage. Safe to call again — it rebuilds
  /// from whatever is still unsynced.
  Future<void> prepare() async {
    _isPreparing = true;
    notifyListeners();

    await SyncUploadStore.instance.load();

    _cases.clear();
    _currentCaseIndex = -1;
    _currentImage = null;

    final List<CRAOfflineData?> craList = await IsarDbService.isarDbService.getListCRAOfflineData();
    final List<PatientRegistration> patients = patientListViewModel.registeredPatients;

    // Cases with CRA data first — these carry the images.
    final Set<String> patientIdsWithCra = {};
    for (final cra in craList) {
      if (cra == null) continue;
      final int index = patients.indexWhere((p) => p.patientId == cra.patientId);
      if (index == -1) continue;

      patientIdsWithCra.add(cra.patientId ?? "");
      _cases.add(_buildCase(patients[index], cra));
    }

    // Registration-only patients that never got a CRA.
    for (final patient in patients.where((p) => p.isSynced == false)) {
      if (patientIdsWithCra.contains(patient.patientId)) continue;
      _cases.add(_buildCase(patient, null));
    }

    _isPreparing = false;
    notifyListeners();
  }

  SyncCaseItem _buildCase(PatientRegistration patient, CRAOfflineData? craData) {
    final Map<String, dynamic> payload = _buildPayload(patient, craData);
    final List<AttachmentDb> attachments = _collectAttachments(payload);

    final List<SyncImageItem> images = [];
    for (final attachment in attachments) {
      final String? path = attachment.dataBytes;
      if (path == null || path.isEmpty) continue;

      final String? known = SyncUploadStore.instance.gridFsIdFor(path);
      images.add(SyncImageItem(
        attachment: attachment,
        fileName: attachment.fileName ?? path.split("/").last,
        filePath: path,
        gridFsId: known,
        progress: known != null ? 1 : 0,
        status: known != null ? SyncItemStatus.done : SyncItemStatus.pending,
      ));
    }

    return SyncCaseItem(patient: patient, craData: craData, images: images);
  }

  /// Walks the payload and returns every attachment in it, wherever it sits —
  /// consent scans, lesion captures and the investigator signature all end up
  /// as [AttachmentDb] instances at different depths.
  List<AttachmentDb> _collectAttachments(dynamic node, [List<AttachmentDb>? found]) {
    final List<AttachmentDb> result = found ?? [];

    if (node is AttachmentDb) {
      result.add(node);
    } else if (node is Map) {
      for (final value in node.values) {
        _collectAttachments(value, result);
      }
    } else if (node is Iterable) {
      for (final value in node) {
        _collectAttachments(value, result);
      }
    }
    return result;
  }

  Map<String, dynamic> _buildPayload(PatientRegistration patient, CRAOfflineData? craData) {
    final Map<String, dynamic> patientJson = patient.toJson();
    final String patientId = patientJson["patientId"];

    final Map<String, dynamic> registrationObj = {
      "registrationObj": {"patientData": patientJson}
    };

    List<dynamic> craSectionModel = [];
    if (craData != null) {
      final Map<String, dynamic> craJson = craData.toJson();
      craSectionModel = craJson['craSectionModel'] ?? [];
      for (final element in craSectionModel) {
        element["extension"] = {"doctorDetails": craJson["docDetails"]};
        element["patientId"] = patientId;
      }
    }

    final Map<String, dynamic> cdrPostObj = {
      "cdrPostObj": craData?.caseId != null
          ? [
              {craData!.caseId: craSectionModel}
            ]
          : []
    };

    return {
      "payloadObj": [
        {
          patientId: [registrationObj, cdrPostObj]
        }
      ],
      "appVersion": Environment.runningEnv.releaseVersion,
    };
  }

  Future<void> start() async {
    if (_isRunning) return;
    if (_cases.isEmpty) await prepare();

    // Only sync cases that haven't gone up yet. A case already marked done is
    // skipped so a completed sync is never re-posted.
    final List<SyncCaseItem> targets = _cases.where((c) => c.status == SyncItemStatus.pending).toList();
    if (targets.isEmpty) return;

    await _run(targets);
  }

  /// Re-runs only the cases that failed. Images already in GridFS are skipped,
  /// so this picks up exactly where it stopped — same patient, same case id.
  Future<void> retryFailed() async {
    if (_isRunning) return;
    final failed = _cases.where((c) => c.status == SyncItemStatus.failed).toList();
    if (failed.isEmpty) return;

    for (final item in failed) {
      item.status = SyncItemStatus.pending;
      item.error = null;
      for (final image in item.images) {
        if (image.status == SyncItemStatus.failed) {
          image.status = SyncItemStatus.pending;
          image.error = null;
          image.progress = 0;
        }
      }
    }
    await _run(failed);
  }

  void stop() {
    _cancelToken?.cancel("Stopped by user");
  }

  Future<void> _run(List<SyncCaseItem> targets) async {
    _isRunning = true;
    _hasRun = true;
    _cancelToken = CancelToken();
    notifyListeners();

    try {
      for (final item in targets) {
        if (_cancelToken?.isCancelled ?? false) break;

        _currentCaseIndex = _cases.indexOf(item);
        item.status = SyncItemStatus.running;
        notifyListeners();

        final bool imagesReady = await _uploadImagesFor(item);
        if (!imagesReady) {
          item.status = SyncItemStatus.failed;
          item.error ??= "Some images could not be uploaded";
          notifyListeners();
          continue;
        }

        await _postCase(item);
        notifyListeners();
      }
    } finally {
      _currentImage = null;
      _currentCaseIndex = -1;
      _isRunning = false;
      _cancelToken = null;
      notifyListeners();
    }
  }

  /// Returns true only when every image of the case is in GridFS.
  Future<bool> _uploadImagesFor(SyncCaseItem item) async {
    for (final image in item.images) {
      if (_cancelToken?.isCancelled ?? false) return false;
      if (image.status == SyncItemStatus.done && image.gridFsId != null) continue;

      image.status = SyncItemStatus.running;
      image.progress = 0;
      _currentImage = image;
      notifyListeners();

      try {
        final String gridFsId = await SyncApiService.instance.uploadImage(
          filePath: image.filePath,
          fileName: image.fileName,
          cancelToken: _cancelToken,
          onProgress: (value) {
            image.progress = value;
            notifyListeners();
          },
        );

        image.gridFsId = gridFsId;
        image.status = SyncItemStatus.done;
        image.progress = 1;
        await SyncUploadStore.instance.remember(image.filePath, gridFsId);
        notifyListeners();
      } catch (e) {
        image.status = SyncItemStatus.failed;
        image.error = e is SyncException ? e.message : e.toString();
        item.error = image.error;
        notifyListeners();
        // Hold the whole case: no partial upload reaches the CDR.
        return false;
      }
    }
    return true;
  }

  Future<void> _postCase(SyncCaseItem item) async {
    // Rebuild so the attachments carried in the payload are the ones we just
    // resolved, then swap the local paths for the GridFS ids.
    final Map<String, dynamic> payload = _buildPayload(item.patient, item.craData);
    final List<AttachmentDb> attachments = _collectAttachments(payload);

    final Map<String, String> idByPath = {
      for (final image in item.images)
        if (image.gridFsId != null) image.filePath: image.gridFsId!
    };

    for (final attachment in attachments) {
      final String? path = attachment.dataBytes;
      if (path == null) continue;
      final String? id = idByPath[path];
      if (id != null) attachment.dataBytes = id;
    }

    try {
      await SyncApiService.instance.postSyncPayload(payload, cancelToken: _cancelToken);

      if (item.caseId != null) {
        await IsarDbService.isarDbService.deleteByCaseId(item.caseId);
      }
      await patientListViewModel.markPatientAsSynced(item.primaryId, item.caseId != null);

      // Only now is it safe to drop the local copies.
      for (final image in item.images) {
        await CommonFunctions().deleteFile(image.filePath);
      }
      await SyncUploadStore.instance.forget(item.images.map((i) => i.filePath));

      item.status = SyncItemStatus.done;
    } catch (e) {
      log("SyncViewModel: case ${item.primaryId} failed: $e");
      item.status = SyncItemStatus.failed;
      item.error = e is SyncException ? e.message : e.toString();
    }
  }
}

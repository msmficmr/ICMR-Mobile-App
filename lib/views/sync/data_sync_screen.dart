import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/utils/app_color_scheme.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/viewModel/patient_list_view_model.dart';
import 'package:mhealth/viewModel/sync_view_model.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';
import 'package:mhealth/widgets/space_widget.dart';
import 'package:provider/provider.dart';

class DataSyncScreen extends StatelessWidget {
  static const String routerPath = "/dataSync";

  const DataSyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SyncViewModel>(
      create: (_) {
        final vm = SyncViewModel(patientListViewModel: context.read<PatientListViewModel>());
        vm.prepare();
        return vm;
      },
      child: const _DataSyncView(),
    );
  }
}

class _DataSyncView extends StatelessWidget {
  const _DataSyncView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SyncViewModel>();

    return PopScope(
      // Leaving mid-run would orphan the upload, so hold the screen until the
      // user stops it.
      canPop: !vm.isRunning,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitleType: CustomAppBarTitleType.TEXT,
          titleText: "Data Sync",
          onLeadingClick: () {
            if (!vm.isRunning) GoRouter.of(context).pop();
          },
        ),
        body: SafeArea(
          child: vm.isPreparing
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SummaryCard(vm: vm),
                            const SpaceWidget(height: 16),
                            if (vm.currentImage != null && vm.isRunning) ...[
                              _CurrentUploadCard(vm: vm),
                              const SpaceWidget(height: 16),
                            ],
                            Text("Cases", style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            const SpaceWidget(height: 8),
                            if (vm.cases.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24),
                                child: Text("Nothing to sync.", style: AppStyles.bodyMedium),
                              ),
                            ...vm.cases.map((item) => _CaseTile(item: item)),
                          ],
                        ),
                      ),
                    ),
                    _Actions(vm: vm),
                  ],
                ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final SyncViewModel vm;
  const _SummaryCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorScheme.kGrayColor.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cases", style: AppStyles.bodyMedium),
              Text("${vm.completedCases} of ${vm.totalCases}", style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SpaceWidget(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Images", style: AppStyles.bodyMedium),
              Text("${vm.uploadedImages} of ${vm.totalImages}", style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          if (vm.failedCases > 0) ...[
            const SpaceWidget(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Failed", style: AppStyles.bodyMedium),
                Text(
                  "${vm.failedCases} case(s), ${vm.failedImages} image(s)",
                  style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold, color: AppColorScheme.errorTextColor),
                ),
              ],
            ),
          ],
          const SpaceWidget(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: vm.totalCases == 0 ? 0 : vm.overallProgress,
              minHeight: 6,
              backgroundColor: AppColorScheme.kPrimaryColor.shade50,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColorScheme.kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentUploadCard extends StatelessWidget {
  final SyncViewModel vm;
  const _CurrentUploadCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    final image = vm.currentImage!;
    final caseItem = vm.currentCase;
    final int index = caseItem == null ? 0 : caseItem.images.indexOf(image) + 1;
    final int total = caseItem?.images.length ?? 0;
    final int percent = (image.progress * 100).clamp(0, 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColorScheme.kPrimaryColor.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Uploading image $index of $total  •  ${caseItem?.label ?? ""}",
            style: AppStyles.bodyMedium.copyWith(color: AppColorScheme.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          const SpaceWidget(height: 6),
          Text(image.fileName, style: AppStyles.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SpaceWidget(height: 10),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: image.progress,
                    minHeight: 6,
                    backgroundColor: AppColorScheme.kPrimaryColor.shade50,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColorScheme.kPrimaryColor),
                  ),
                ),
              ),
              const SpaceWidget(width: 10),
              Text("$percent%", style: AppStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _CaseTile extends StatelessWidget {
  final SyncCaseItem item;
  const _CaseTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColorScheme.kGrayColor.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _statusIcon(item.status),
          const SpaceWidget(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label, style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                const SpaceWidget(height: 4),
                Text(
                  item.images.isEmpty ? "No images" : "${item.uploadedImageCount} of ${item.images.length} images uploaded",
                  style: AppStyles.bodySmall,
                ),
                if (item.error != null) ...[
                  const SpaceWidget(height: 4),
                  Text(item.error!, style: AppStyles.bodySmall.copyWith(color: AppColorScheme.errorTextColor)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(SyncItemStatus status) {
    switch (status) {
      case SyncItemStatus.done:
        return const Icon(Icons.check_circle, color: Colors.green, size: 22);
      case SyncItemStatus.failed:
        return const Icon(Icons.error, color: AppColorScheme.errorTextColor, size: 22);
      case SyncItemStatus.running:
        return const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2));
      case SyncItemStatus.pending:
        return Icon(Icons.schedule, color: AppColorScheme.kGrayColor.shade400, size: 22);
    }
  }
}

class _Actions extends StatelessWidget {
  final SyncViewModel vm;
  const _Actions({required this.vm});

  @override
  Widget build(BuildContext context) {
    // Running: only a Stop control.
    if (vm.isRunning) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: PrimaryFilledButton(
            buttonTitle: "Stop",
            widgetKey: "key_button_sync_stop",
            onPressed: vm.stop,
          ),
        ),
      );
    }

    // Everything synced with no failures — nothing to sync again.
    if (vm.allSynced) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SpaceWidget(width: 8),
            Text(
              "All data synced",
              style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Only offer a retry when something actually failed.
          if (vm.failedCases > 0) ...[
            SizedBox(
              width: double.infinity,
              child: PrimaryFilledButton(
                buttonTitle: "Retry failed (${vm.failedCases})",
                widgetKey: "key_button_sync_retry",
                onPressed: vm.retryFailed,
              ),
            ),
            if (vm.pendingCases > 0) const SpaceWidget(height: 10),
          ],
          // Sync the cases that haven't gone up yet (initial run, or whatever
          // was left after a stop). Completed cases are never re-posted.
          if (vm.pendingCases > 0)
            SizedBox(
              width: double.infinity,
              child: PrimaryFilledButton(
                buttonTitle: vm.hasRun ? "Sync remaining (${vm.pendingCases})" : "Start sync",
                widgetKey: "key_button_sync_start",
                onPressed: vm.start,
              ),
            ),
        ],
      ),
    );
  }
}

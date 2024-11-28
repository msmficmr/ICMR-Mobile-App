import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mhealth/services/permission_service.dart';
import 'package:mhealth/utils/app_styles.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:mhealth/views/dashboard/dashboard_screen.dart';
import 'package:mhealth/widgets/custom_app_bar.dart';
import 'package:mhealth/widgets/primary_filled_button.dart';

class StoragePermissionScreen extends StatefulWidget {
  static const String routerPath = "/storagePermission";
  const StoragePermissionScreen({super.key});

  @override
  State<StoragePermissionScreen> createState() => _StoragePermissionScreenState();
}

class _StoragePermissionScreenState extends State<StoragePermissionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestAppPermissions();
    });
  }

  requestAppPermissions() async {
    bool permission = await PermissionService.requestStoragePermission(context);
    if (permission) {
      if (mounted) {
        GoRouter.of(context).go(DashboardScreen.routerPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitleType: CustomAppBarTitleType.HORIZONTAL_APP_ICON,
        hasLeading: false,
        centerTitle: true,
        onLeadingClick: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We require storage permission to use this app. Please grant storage permissions in your app settings.",
                style: AppStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              PrimaryFilledButton(
                buttonTitle: "Yes i have given permission",
                widgetKey: "permission_button",
                onPressed: () {
                  requestAppPermissions();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

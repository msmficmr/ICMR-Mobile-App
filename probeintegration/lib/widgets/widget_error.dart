import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:probeintegration/utils/probe_constants.dart';
import 'package:probeintegration/utils/probe_enums.dart';

class WidgetError extends StatelessWidget {
  final VoidCallback? onRetry;
  final WidgetEnums type;
  const WidgetError({super.key, this.onRetry, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WidgetEnums.storagePermission:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.storage,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Storage Permission", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please allow storage permission", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );
      case WidgetEnums.usbPermission:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icUSB,
                  height: 40,
                  width: 40,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("USB Permission", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please allow USB permission", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );
      case WidgetEnums.bluetoothOff:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icBluetooth,
                  height: 40,
                  width: 40,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Bluetooth is turned off", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please turn on bluetooth", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );
      case WidgetEnums.bluetoothPermission:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icBluetooth,
                  height: 40,
                  width: 40,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Bluetooth Permission", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please allow bluetooth permission", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );
      case WidgetEnums.cameraPermission:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icCamera,
                  height: 40,
                  width: 40,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Camera Permission", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please allow camera permission", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );

      case WidgetEnums.scanning:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xffF4CF70),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Please wait,", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Scanning devices", style: Theme.of(context).textTheme.titleSmall))
            ],
          ),
        );
      case WidgetEnums.usbDisconnected:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icUSB,
                  height: 40,
                  width: 40,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("USB Disconnected", style: Theme.of(context).textTheme.titleSmall)),
              Center(child: Text("Please connect probe through USB", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500)))
            ],
          ),
        );
      case WidgetEnums.probeOffline:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icNotOnline,
                  height: 100,
                  width: 100,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Probe not found", style: Theme.of(context).textTheme.titleSmall)),
            ],
          ),
        );

      case WidgetEnums.other:
        return _ErrorWidget(
          onRetry: onRetry,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ProbeConstants.icNotOnline,
                  height: 100,
                  width: 100,
                  colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: Text("Something went wrong", style: Theme.of(context).textTheme.titleSmall)),
            ],
          ),
        );
    }
  }
}

class _ErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final Widget child;
  const _ErrorWidget({super.key, required this.child, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        child,
        const Spacer(),
        if (onRetry != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            ),
          ),
      ],
    );
  }
}

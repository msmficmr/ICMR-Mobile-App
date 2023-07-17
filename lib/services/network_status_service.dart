import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';

/// Keeps track of network status across the app
/// Note that connectivity changes are no longer communicated to Android apps in the background starting with Android 8.0. You should always check for connectivity status when your app is resumed. The broadcast is only useful when your application is in the foreground.
/// Note that on Android, this does not guarantee connection to Internet. For instance, the app might have wifi access but it might be a VPN or a hotel WiFi with no access.

class NetworkStatusService extends ChangeNotifier {
  NetworkStatus _networkStatus = NetworkStatus.online;
  final Connectivity _connectivity = Connectivity();

  NetworkStatus get networkStatus => _networkStatus;

  NetworkStatusService() {
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult connectivityResult;

    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      return;
    }

    NetworkStatus newNetworkStatus = evaluateConnectivityResult(connectivityResult: connectivityResult);
    _connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      onNetworkStatusChange(connectivityResult: connectivityResult);
    });

    return setNetworkStatus(networkStatus: newNetworkStatus);
  }

  void setNetworkStatus({required NetworkStatus networkStatus}) {
    if (_networkStatus != networkStatus) {
      _networkStatus = networkStatus;
      notifyListeners();
    }
  }

  /**************************************************************** Functions */
  /// Takes in connectivity result and tells if that evaluates to client being
  /// online or offline
  NetworkStatus evaluateConnectivityResult({required ConnectivityResult connectivityResult}) {
    if (connectivityResult == ConnectivityResult.none) {
      return NetworkStatus.offline;
    }

    return NetworkStatus.online;
  }

  /// called whenever the connectivity status changes,
  /// it sets Network status and creates a toast message
  void onNetworkStatusChange({required ConnectivityResult connectivityResult}) {
    NetworkStatus newNetworkStatus = evaluateConnectivityResult(connectivityResult: connectivityResult);
    if (_networkStatus != newNetworkStatus) {
      setNetworkStatus(networkStatus: newNetworkStatus);
      CommonFunctions.toastMessage("You are ${_networkStatus.name}");
    }
  }
}

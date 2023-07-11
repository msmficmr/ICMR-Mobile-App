// ignore_for_file: non_constant_identifier_names,

import 'package:flutter/material.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:location/location.dart';

class LocationService {
  LocationService._();

  final String _ERROR_LOCATION_SERVICE_DISABLED = "Location services are currently disabled. Please enable location services in your device settings.";
  final String _ERROR_LOCATION_PERMISSION_DENIED = "Location permissions are currently denied. Please grant location permissions in your app settings.";
  final String _ERROR_LOCATION_PERMISSION_PERMANENT_DENIED = "Location permissions are permanently denied, Please grant location permissions in your app settings.";
  final String _ERROR_LOCATION_PERMISSION_IN_USE =
      "Location permissions are currently allowed only while using the app. Please grant location permissions as always because we collect location data to calculate expense reimbursement based on distance travelled even when app is closed or not in use.";
  final String _ENABLE_LOCATION_CTA = "Enable Location Services";
  final String _GRANT_LOCATION_CTA = "Grant Location Permissions";

  static LocationService locationServiceInstance = LocationService._();

  final Location _location = Location();

  /// [getPermissionStatus] returns [LocationPermissionStatus] enum based on [permissionStatus]
  Future<LocationPermissionStatus> getPermissionStatus(PermissionStatus permissionStatus, bool enableBackgroundMode) async {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        bool isAlwaysAllowed = await _isBackgroundLocationEnabled(enableBackgroundMode);
        return isAlwaysAllowed ? LocationPermissionStatus.GRANTED : LocationPermissionStatus.WHILE_IN_USE;
      case PermissionStatus.grantedLimited:
        return LocationPermissionStatus.WHILE_IN_USE;
      case PermissionStatus.denied:
        return LocationPermissionStatus.DENIED;
      case PermissionStatus.deniedForever:
        return LocationPermissionStatus.FOREVER_DENIED;
      default:
        return LocationPermissionStatus.GRANTED;
    }
  }

  /// [requestLocationService] is to return [LocationPermissionStatus]
  Future<LocationPermissionStatus> requestLocationService({bool enableBackgroundMode = false}) async {
    /// before checking permission we need to either location service is enabled or not
    /// if location service is not enable then we will return [SERVICE_DISABLED] as enum
    bool isLocationServiceEnabled = await _location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      return LocationPermissionStatus.SERVICE_DISABLED;
    }

    /// if location service is enabled then we will check status of location permission for the app.
    PermissionStatus permissionStatus = await _location.hasPermission();

    return getPermissionStatus(permissionStatus, enableBackgroundMode);
  }

  /// This function check either permission is given as All the time
  _isBackgroundLocationEnabled(bool enableBackgroundMode) async {
    bool hasPermission = await _location.isBackgroundModeEnabled();
    if (!hasPermission && enableBackgroundMode) {
      try {
        await _location.enableBackgroundMode();
        hasPermission = await _location.isBackgroundModeEnabled();
      } catch (e) {
        return false;
      }
    }

    return hasPermission;
  }

  /// [checkPermission] helps you to check either location permission is given to app or not
  /// it will return status of permission in bool format
  /// if user granted permission of location as `Always` then it will return `true`
  /// otherwise it will return `false`
  Future<bool> checkPermission(
    BuildContext context,
  ) async {
    /// checks the status of location from [PermissionService] class
    LocationPermissionStatus serviceStatus = await requestLocationService(enableBackgroundMode: true);
    switch (serviceStatus) {
      case LocationPermissionStatus.GRANTED:
        return true;
      case LocationPermissionStatus.DENIED:
        if (context.mounted) {
          /// if user deny or close the permission dialog we will display alert to the user.
          await CommonFunctions.openDialog(
            context: context,
            subtitle: _ERROR_LOCATION_PERMISSION_DENIED,
            buttonText: _GRANT_LOCATION_CTA,
          );
        }

        /// again we are requesting permission from user.
        PermissionStatus requestPermissionStatus = await _location.requestPermission();

        if (requestPermissionStatus == PermissionStatus.granted) {
          bool isAlwaysAllowed = await _isBackgroundLocationEnabled(true);
          if (isAlwaysAllowed) {
            return true;
          } else {
            if (context.mounted) {
              _showPermissionDialog(context, LocationPermissionStatus.WHILE_IN_USE);
            }
          }
        } else {
          LocationPermissionStatus permissionStatus = await getPermissionStatus(requestPermissionStatus, true);
          if (context.mounted) {
            /// if user has not given permission to the app . we will display alert to the user
            _showPermissionDialog(context, permissionStatus);
          }
        }
        return false;
      default:
        if (context.mounted) {
          /// displaying alert to the user
          _showPermissionDialog(context, serviceStatus);
        }
        return false;
    }
  }

  void _showPermissionDialog(BuildContext context, LocationPermissionStatus status) {
    switch (status) {
      /// if Location service is disabled then we will display alert
      /// if user click on alert button it will open Location service setting of mobile.
      case LocationPermissionStatus.SERVICE_DISABLED:
        CommonFunctions.openDialog(context: context, action: CommonFunctions.openLocationSettings, subtitle: _ERROR_LOCATION_SERVICE_DISABLED, buttonText: _ENABLE_LOCATION_CTA);
        break;

      /// if Location Permission is denied forever  then we will display alert
      /// if user click on alert button it will open K-Lab Collection App Setting.
      case LocationPermissionStatus.FOREVER_DENIED:
        CommonFunctions.openDialog(context: context, action: CommonFunctions.openAppSettings, subtitle: _ERROR_LOCATION_PERMISSION_PERMANENT_DENIED, buttonText: _GRANT_LOCATION_CTA);
        break;

      /// if Location Permission is allowed but only while using the app then we will display alert
      /// if user click on alert button it will open K-Lab Collection App Setting.
      case LocationPermissionStatus.WHILE_IN_USE:
        CommonFunctions.openDialog(context: context, action: CommonFunctions.openAppSettings, subtitle: _ERROR_LOCATION_PERMISSION_IN_USE, buttonText: _GRANT_LOCATION_CTA);
        break;
      default:
        CommonFunctions.openDialog(context: context, action: CommonFunctions.openAppSettings, subtitle: _ERROR_LOCATION_SERVICE_DISABLED, buttonText: _GRANT_LOCATION_CTA);
        break;
    }
  }
}

// ignore_for_file: non_constant_identifier_names,

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/enums.dart';
import 'package:location/location.dart';

class LocationService {
  LocationService._();

  final String _ERROR_LOCATION_SERVICE_DISABLED = "Location services are currently disabled. Please enable location services in your device settings.";
  final String _ERROR_LOCATION_PERMISSION_DENIED = "Location permissions are currently denied. Please grant location permissions in your app settings.";
  final String _ERROR_LOCATION_PERMISSION_PERMANENT_DENIED = "Location permissions are permanently denied, Please grant location permissions in your app settings.";
  final String _ENABLE_LOCATION_CTA = "Enable Location Services";
  final String _GRANT_LOCATION_CTA = "Grant Location Permissions";

  static LocationService locationServiceInstance = LocationService._();

  final Location _location = Location();

  Future<LocationPermissionStatus> getPermissionStatus(PermissionStatus permissionStatus) async {
    switch (permissionStatus) {
      case PermissionStatus.granted:
        return LocationPermissionStatus.GRANTED;
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

  Future<LocationPermissionStatus> requestLocationService() async {
    bool isLocationServiceEnabled = await _location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      return LocationPermissionStatus.SERVICE_DISABLED;
    }

    PermissionStatus permissionStatus = await _location.hasPermission();
    return getPermissionStatus(permissionStatus);
  }

  Future<bool> checkPermission(BuildContext context) async {
    LocationPermissionStatus serviceStatus = await requestLocationService();
    switch (serviceStatus) {
      case LocationPermissionStatus.GRANTED:
        return true;
      case LocationPermissionStatus.DENIED:
        if (context.mounted) {
          await CommonFunctions.openDialog(
            context: context,
            subtitle: _ERROR_LOCATION_PERMISSION_DENIED,
            buttonText: _GRANT_LOCATION_CTA,
            action: (BuildContext context) {
              Navigator.pop(context);
            },
          );
        }
        PermissionStatus requestPermissionStatus = await _location.requestPermission();

        if (requestPermissionStatus == PermissionStatus.granted) {
          return true;
        } else {
          LocationPermissionStatus permissionStatus = await getPermissionStatus(requestPermissionStatus);
          if (context.mounted) {
            /// if user has not given permission to the app . we will display alert to the user
            _showPermissionDialog(context, permissionStatus);
          }
        }
        return false;
      default:
        if (context.mounted) {
          _showPermissionDialog(context, serviceStatus);
        }
        return false;
    }
  }

  void _showPermissionDialog(BuildContext context, LocationPermissionStatus status) {
    switch (status) {
      case LocationPermissionStatus.SERVICE_DISABLED:
        CommonFunctions.openDialog(
            context: context,
            action: (context) {
              CommonFunctions.openLocationSettings();
              Navigator.pop(context);
            },
            subtitle: _ERROR_LOCATION_SERVICE_DISABLED,
            buttonText: _ENABLE_LOCATION_CTA);
        break;
      case LocationPermissionStatus.FOREVER_DENIED:
        CommonFunctions.openDialog(
            context: context,
            action: (context) {
              CommonFunctions.openAppSettings();
              Navigator.pop(context);
            },
            subtitle: _ERROR_LOCATION_PERMISSION_PERMANENT_DENIED,
            buttonText: _GRANT_LOCATION_CTA);
        break;
      default:
        CommonFunctions.openDialog(
            context: context,
            action: (context) {
              CommonFunctions.openAppSettings();
              Navigator.pop(context);
            },
            subtitle: _ERROR_LOCATION_SERVICE_DISABLED,
            buttonText: _GRANT_LOCATION_CTA);
        break;
    }
  }
}

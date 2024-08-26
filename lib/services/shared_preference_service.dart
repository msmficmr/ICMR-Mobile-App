import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;
  SharedPreferencesService._();
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferencesService sharedPreferencesService = SharedPreferencesService._();

  // [readData] method is used to read a particular key from local storage
  String? readData({required String key}) {
    return _prefs?.getString(key);
  }

  /// [readBool] method is used to get bool value for a particular key from local storage
  Future<bool?> readBool({required String key}) async {
    return _prefs?.getBool(key);
  }

  /// [readInt] method is used to read int value for a particular key from local storage
  Future<int?> readInt({required String key}) async {
    return _prefs?.getInt(key);
  }

  /// [readDouble] method is used to read double value for a particular key from local storage
  Future<double?> readDouble({required String key}) async {
    return _prefs?.getDouble(key);
  }

  /// [writeString] method is used to write String data to local storage
  Future<void> writeString({required String key, required String value}) async {
    await _prefs?.setString(key, value);
  }

  /// [writeString] method is used to write Int data to local storage
  Future<void> writeInt({required String key, required int value}) async {
    await _prefs?.setInt(key, value);
  }

  /// [writeString] method is used to write Double data to local storage
  Future<void> writeDouble({required String key, required double value}) async {
    await _prefs?.setDouble(key, value);
  }

  /// [removeString] method is used to delete particular String data from local storage
  Future<void> removeString({required String key}) async {
    await _prefs?.remove(key);
  }

  /// [clearAll] method is used to delete all keys from local storage
  Future<void> clearAll() async {
    await _prefs?.clear();
  }

  /// [hasKey] method is used to check particular key is exists in local storage or not.
  Future<bool> hasKey(String key) async {
    return _prefs!.containsKey(key);
  }
}

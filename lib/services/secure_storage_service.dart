import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();
  static SecureStorageService storageService = SecureStorageService._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_PKCS1Padding,
      encryptedSharedPreferences: true,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    ),
    iOptions: IOSOptions(),
  );

  /// [readData] method is used to read particular key from local storage
  Future<String?> readData({required String key}) async {
    return await _storage.read(key: key);
  }

  /// [writeData] method is used to write data to local storage
  Future<void> writeData({required String key, required String value}) async {
    return await _storage.write(key: key, value: value);
  }

  /// [deleteData] method is used to delete particular data from local storage
  Future<void> deleteData(String key) async {
    return await _storage.delete(key: key);
  }

  /// [clearAll] method is used to delete all keys from local storage
  Future<void> clearAll() async {
    return await _storage.deleteAll();
  }

  /// [hasKey] method is used to check particular key is exists in local storage or not.
  Future<bool> hasKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}

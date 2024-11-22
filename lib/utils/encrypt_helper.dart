import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:mhealth/config/environment/environment.dart';

class EncryptionHelper {
  // Adjust key to be 32 bytes (256 bits)
  static final String _key = Environment.runningEnv.encryptionKey;

  // Encrypt a plain text
  static String encryptText(String plainText) {
    final key = _getFormattedKey();
    final iv = encrypt.IV.fromLength(16); // Generate a random 16-byte IV
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Combine IV and encrypted text, separated by a delimiter
    final combined = '${iv.base64}:${encrypted.base64}';
    return combined;
  }

  // Decrypt an encrypted text
  static String decryptText(String encryptedText) {
    final key = _getFormattedKey();
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Split the IV and the ciphertext
    final parts = encryptedText.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid encrypted text format');
    }

    final iv = encrypt.IV.fromBase64(parts[0]);
    final ciphertext = parts[1];

    final decrypted = encrypter.decrypt64(ciphertext, iv: iv);
    return decrypted;
  }

  // Format the key to ensure it's exactly 32 bytes (256 bits)
  static encrypt.Key _getFormattedKey() {
    String formattedKey = _key;

    if (_key.length < 32) {
      // Pad with zeros if the key is shorter than 32 characters
      formattedKey = _key.padRight(32, '0');
    } else if (_key.length > 32) {
      // Truncate if the key is longer than 32 characters
      formattedKey = _key.substring(0, 32);
    }

    return encrypt.Key.fromUtf8(formattedKey);
  }
}

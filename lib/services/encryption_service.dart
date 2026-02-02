import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  static final EncryptionService instance = EncryptionService._internal();
  EncryptionService._internal();

  final _secureStorage = const FlutterSecureStorage();
  static const String _keyStorageKey = 'encryption_key';
  static const String _ivStorageKey = 'encryption_iv';

  encrypt.Key? _key;
  encrypt.IV? _iv;
  encrypt.Encrypter? _encrypter;

  Future<void> init() async {
    // Get or create encryption key
    String? keyString = await _secureStorage.read(key: _keyStorageKey);
    String? ivString = await _secureStorage.read(key: _ivStorageKey);

    if (keyString == null || ivString == null) {
      // Generate new key and IV
      _key = encrypt.Key.fromSecureRandom(32);
      _iv = encrypt.IV.fromSecureRandom(16);

      // Store them securely
      await _secureStorage.write(
        key: _keyStorageKey,
        value: _key!.base64,
      );
      await _secureStorage.write(
        key: _ivStorageKey,
        value: _iv!.base64,
      );
    } else {
      // Load existing key and IV
      _key = encrypt.Key.fromBase64(keyString);
      _iv = encrypt.IV.fromBase64(ivString);
    }

    _encrypter = encrypt.Encrypter(encrypt.AES(_key!));
  }

  String encryptText(String plainText) {
    if (_encrypter == null || _iv == null) {
      throw Exception('Encryption service not initialized');
    }
    return _encrypter!.encrypt(plainText, iv: _iv).base64;
  }

  String decryptText(String encryptedText) {
    if (_encrypter == null || _iv == null) {
      throw Exception('Encryption service not initialized');
    }
    return _encrypter!.decrypt64(encryptedText, iv: _iv);
  }

  Future<void> resetEncryption() async {
    await _secureStorage.delete(key: _keyStorageKey);
    await _secureStorage.delete(key: _ivStorageKey);
    await init();
  }
}

import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notehax/constants/app_constants.dart';

class BiometricService {
  static final BiometricService instance = BiometricService._internal();
  BiometricService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  final _secureStorage = const FlutterSecureStorage();

  Future<bool> isBiometricsAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  Future<bool> authenticate({
    required String reason,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> setBiometricsEnabled(bool enabled) async {
    await _secureStorage.write(
      key: StorageKeys.biometricsEnabled,
      value: enabled.toString(),
    );
  }

  Future<bool> isBiometricsEnabled() async {
    final value = await _secureStorage.read(
      key: StorageKeys.biometricsEnabled,
    );
    return value == 'true';
  }

  Future<void> setPin(String pin) async {
    await _secureStorage.write(
      key: StorageKeys.pin,
      value: pin,
    );
  }

  Future<String?> getPin() async {
    return await _secureStorage.read(key: StorageKeys.pin);
  }

  Future<bool> verifyPin(String enteredPin) async {
    final storedPin = await getPin();
    return storedPin == enteredPin;
  }

  Future<bool> hasPin() async {
    final pin = await getPin();
    return pin != null && pin.isNotEmpty;
  }

  Future<void> removePin() async {
    await _secureStorage.delete(key: StorageKeys.pin);
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:root_checker_plus/root_checker_plus.dart';
import 'package:screen_protector/screen_protector.dart';

import '../models/check_safe.dart';

class SecurityService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final LocalAuthentication _auth = LocalAuthentication();

  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static const String _keyScreenshot =
      'security_screenshot_blocked';

  static const String _keyBiometric =
      'security_biometric_enabled';

  Future<SecurityCheckModel> performSecurityChecks() async {
    final bool isRooted =
        await RootCheckerPlus.isRootChecker() ?? false;

    final bool isEmulator =
        await _checkIsEmulator();

    final bool isTampered =
        await _checkIsTampered();

    final bool biometricAvailable =
        await _isBiometricAvailable();

    final bool isBiometricEnabled =
        await _readBool(_keyBiometric) ??
            biometricAvailable;

    final bool isScreenshotBlocked =
        await _readBool(_keyScreenshot) ??
            true;

    await _applyScreenshotPolicy(
      isScreenshotBlocked,
    );

    return SecurityCheckModel(
      isRooted: isRooted,
      isEmulator: isEmulator,
      isTampered: isTampered,
      isBiometricEnabled: isBiometricEnabled,
      isSecureStorage: true,
      isScreenshotBlocked: isScreenshotBlocked,
    );
  }

  Future<bool> _checkIsEmulator() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo info =
          await _deviceInfo.androidInfo;

      return !info.isPhysicalDevice;
    }

    if (Platform.isIOS) {
      final IosDeviceInfo info =
          await _deviceInfo.iosInfo;

      return !info.isPhysicalDevice;
    }

    return false;
  }

  Future<bool> _checkIsTampered() async {
    final PackageInfo packageInfo =
        await PackageInfo.fromPlatform();

    const String expectedPackageName =
        'com.example.bank';

    return packageInfo.packageName !=
        expectedPackageName;
  }

  Future<bool> _isBiometricAvailable() async {
    final bool canCheck =
        await _auth.canCheckBiometrics;

    final bool supported =
        await _auth.isDeviceSupported();

    return canCheck && supported;
  }

  Future<void> updateBiometricPolicy(
      bool enable) async {
    if (enable) {
      final bool available =
          await _isBiometricAvailable();

      if (!available) {
        throw Exception(
          'دستگاه از احراز هویت بیومتریک پشتیبانی نمی‌کند.',
        );
      }
    }

    await _writeBool(
      _keyBiometric,
      enable,
    );
  }

  Future<void> updateScreenshotPolicy(
      bool enable) async {
    await _writeBool(
      _keyScreenshot,
      enable,
    );

    await _applyScreenshotPolicy(
      enable,
    );
  }

  Future<void> _applyScreenshotPolicy(
      bool enable,
  ) async {
    try {
      if (enable) {
        await ScreenProtector
            .preventScreenshotOn();
      } else {
        await ScreenProtector
            .preventScreenshotOff();
      }
    } catch (_) {
      // Ignore platform specific errors
    }
  }

  Future<bool?> _readBool(
      String key) async {
    final String? value =
        await _storage.read(key: key);

    if (value == null) {
      return null;
    }

    return value.toLowerCase() == 'true';
  }

  Future<void> _writeBool(
    String key,
    bool value,
  ) async {
    await _storage.write(
      key: key,
      value: value.toString(),
    );
  }
}
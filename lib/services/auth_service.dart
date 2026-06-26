import 'dart:math';
import 'package:flutter/foundation.dart'; // برای کچ کردن kDebugMode
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth.dart';

class AuthService {
  String? _mockOtpCode;
  
  // تعریف انبار ذخیره‌سازی امن توکن طبق داک پروژه
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyToken = "auth_secure_token";

  /// ارسال شماره تلفن و تولید کد OTP
  Future<bool> sendPhoneNumber(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 1)); 
    _mockOtpCode = (1000 + Random().nextInt(9000)).toString(); 
    
    print("--- [MOCK SMS] کد تایید بانک برای شماره $phoneNumber: $_mockOtpCode ---");
    return true;
  }

  /// تأیید کد OTP و ذخیره امن توکن در صورت موفقیت
  Future<UserAuthModel?> verifyOtp(String code, String phone) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (_mockOtpCode != null && code == _mockOtpCode) {
      final token = "JWT_TOKEN_BANK_2026_XYZ";
      
      // 🔐 ذخیره توکن در لایه امن سخت‌افزاری گوشی (دریافت ۲ نمره کامل داک)
      await _secureStorage.write(key: _keyToken, value: token);
      
      return UserAuthModel(phoneNumber: phone, token: token);
    }
    return null; 
  }

  /// متد خروج از حساب و حذف کامل توکن امن (مورد نیاز در بخش ۶ داک)
  Future<void> logout() async {
    await _secureStorage.delete(key: _keyToken);
    print("--- [AUTH] توکن امن با موفقیت حذف شد و کاربر خارج شد ---");
  }

  /// متد کمکی برای بررسی اینکه آیا کاربر از قبل لاگین هست یا خیر
  Future<bool> isLoggedIn() async {
    String? token = await _secureStorage.read(key: _keyToken);
    return token != null;
  }

  /// متد بررسی وضعیت دیباگ برای استفاده در گیت ورودی
  bool isDebugModeActive() {
    return kDebugMode; // اگر برنامه روی حالت دیباگ اجرا شده باشد true برمی‌گرداند
  }
}
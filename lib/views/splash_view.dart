import 'package:flutter/material.dart';
import '../presenter/splash_presenter.dart';
import 'Isplash_view.dart';
// 📥 ایمپورت کردن ویجت‌های اختصاصی خودت
import '../widgets/HeaderWidget.dart'; // اگر در اسپلش هدر داری
import '../widgets/LogoWidget.dart';  
import '../widgets/LoaderWidget.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> implements ISplashView {
  late SplashPresenter _presenter;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = SplashPresenter(this);
    _presenter.checkInitialRoute();
  }

  @override
  void showLoading() => setState(() => _errorMessage = null);

  @override
  void showSecurityError(String message) => setState(() => _errorMessage = message);

  @override
  void navigateToLogin() => print("Navigate to Login Screen");

  @override
  void navigateToBiometric() => print("Navigate to Biometric Screen");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70585b),
      body: Center(
        child: _errorMessage != null
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFffdad6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFba1a1a)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFba1a1a), size: 48),
                      const SizedBox(height: 16),
                      Text(_errorMessage!, style: const TextStyle(color: Color(0xFF93000a), fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderWidget(), // 🎨 ۱. استفاده از هدر اختصاصی خودت به جای متن ساده
                  // 🎨 ۱. استفاده از لوگوی اختصاصی خودت به جای آیکون پیش‌فرض
                  LogoWidget(), 
                  const SizedBox(height: 24),
                  const Text(
                    "بانکداری امن مینی‌لب",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  // ⚡ ۲. استفاده از لودر اختصاصی خودت به جای CircularProgressIndicator
                  LoaderWidget(), 
                ],
              ),
      ),
    );
  }
}
import '../services/security_service.dart';
import '../services/auth_service.dart';
import '../views/Isplash_view.dart';


class SplashPresenter {
  final ISplashView _view;
  final SecurityService _securityService = SecurityService();
  final AuthService _authService = AuthService();

  SplashPresenter(this._view);

  void checkInitialRoute() async {
    _view.showLoading();
    
    // ۱. بررسی سلامت سخت‌افزاری دستگاه
    final report = await _securityService.performSecurityChecks();
    
    // اگر روت یا شبیه‌ساز بود، بلافاصله گیت را ببند
    if (!report.isDeviceSafe) {
      _view.showSecurityError("به دلیل ناامن بودن محیط اجرا، امکان استفاده از برنامه وجود ندارد.");
      return;
    }

    // ۲. بررسی وضعیت لاگین قبلی کاربر در حافظه امن
    bool loggedIn = await _authService.isLoggedIn();
    
    if (loggedIn) {
      // اگر قبلاً لاگین کرده، طبق داک برای ورود به بخش حساس باید بیومتریک دهد
      _view.navigateToBiometric();
    } else {
      _view.navigateToLogin();
    }
  }
}
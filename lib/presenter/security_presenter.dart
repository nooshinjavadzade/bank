import '../models/check_safe.dart';
import '../services/security_service.dart';

abstract class ISecurityView {
  void showSecurityReport(SecurityCheckModel report);
  void showLoading();
  void onError(String message);
  void showStatusMessage(String message); // برای نشان دادن پیغام موفقیت‌آمیز بودن تغییرات
}

class SecurityPresenter {
  final ISecurityView _view;
  final SecurityService _securityService = SecurityService();
  
  // نگهداری وضعیت فعلی در پرزنتر برای مدیریت راحت‌تر تغییرات
  SecurityCheckModel? _currentReport;

  SecurityPresenter(this._view);

  /// ۱. بارگذاری اولیه تمام وضعیت‌ها
  void runSecurityCheck() async {
    _view.showLoading();
    try {
      _currentReport = await _securityService.performSecurityChecks();
      _view.showSecurityReport(_currentReport!);
    } catch (e) {
      _view.onError("خطا در بررسی وضعیت امنیتی: ${e.toString()}");
    }
  }

  /// ۲. تغییر وضعیت جلوگیری از اسکرین‌شات
  void toggleScreenshotBlocking(bool enable) async {
    if (_currentReport == null) return;

    try {
      // دستور به سرویس برای اعمال یا حذف فلگ امنیتی در سیستم‌عامل
      await _securityService.updateScreenshotPolicy(enable);
      
      // ساخت یک مدل جدید با وضعیتِ آپدیت شده (کپی کردن مدل قبلی و تغییر یک فیلد)
      _currentReport = SecurityCheckModel(
        isRooted: _currentReport!.isRooted,
        isEmulator: _currentReport!.isEmulator,
        isTampered: _currentReport!.isTampered,
        isBiometricEnabled: _currentReport!.isBiometricEnabled,
        isSecureStorage: _currentReport!.isSecureStorage,
        isScreenshotBlocked: enable, // وضعیت جدید
      );

      _view.showSecurityReport(_currentReport!);
      _view.showStatusMessage(enable ? "جلوگیری از اسکرین‌شات فعال شد" : "جلوگیری از اسکرین‌شات غیرفعال شد");
    } catch (e) {
      _view.onError("خطا در تغییر وضعیت اسکرین‌شات");
    }
  }

  /// ۳. تغییر وضعیت احراز هویت بیومتریک
  void toggleBiometricAuthentication(bool enable) async {
    if (_currentReport == null) return;

    try {
      // در دنیای واقعی اینجا وضعیت را در SharedPreferences یا دیتابیس لوکال ذخیره می‌کنیم
      // تا در لاگین بعدی بدانیم کاربر اثر انگشت می‌خواهد یا خیر.
      await _securityService.updateBiometricPolicy(enable);

      _currentReport = SecurityCheckModel(
        isRooted: _currentReport!.isRooted,
        isEmulator: _currentReport!.isEmulator,
        isTampered: _currentReport!.isTampered,
        isBiometricEnabled: enable, // وضعیت جدید
        isSecureStorage: _currentReport!.isSecureStorage,
        isScreenshotBlocked: _currentReport!.isScreenshotBlocked,
      );

      _view.showSecurityReport(_currentReport!);
      _view.showStatusMessage(enable ? "ورود با اثر انگشت فعال شد" : "ورود با اثر انگشت غیرفعال شد");
    } catch (e) {
      _view.onError("خطا در تغییر وضعیت بیومتریک");
    }
  }

  /// ۴. تغییر وضعیت ذخیره‌سازی امن
  void toggleSecureStorage(bool enable) async {
    if (_currentReport == null) return;

    try {
      _currentReport = SecurityCheckModel(
        isRooted: _currentReport!.isRooted,
        isEmulator: _currentReport!.isEmulator,
        isTampered: _currentReport!.isTampered,
        isBiometricEnabled: _currentReport!.isBiometricEnabled,
        isSecureStorage: enable, // وضعیت جدید
        isScreenshotBlocked: _currentReport!.isScreenshotBlocked,
      );

      _view.showSecurityReport(_currentReport!);
      _view.showStatusMessage(enable ? "ذخیره‌سازی رمزنگاری شده فعال شد" : "ذخیره‌سازی روی حالت عادی قرار گرفت");
    } catch (e) {
      _view.onError("خطا در تغییر وضعیت ذخیره‌سازی");
    }
  }
}
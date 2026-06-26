import '../services/auth_service.dart';
import '../views/IAuthView.dart';
class AuthPresenter {
  final IAuthView _view;
  final AuthService _authService;

  AuthPresenter(this._view, this._authService);

  void requestOtp(String phone) async {
    if (phone.isEmpty || phone.length < 11) {
      _view.onAuthError("لطفاً شماره موبایل ۱۱ رقمی معتبر وارد کنید");
      return;
    }
    _view.showLoading();
    bool success = await _authService.sendPhoneNumber(phone);
    _view.hideLoading();
    
    if (success) {
      _view.onOtpSentSuccess();
    } else {
      _view.onAuthError("خطا در ارسال پیامک. مجدداً تلاش کنید");
    }
  }

  void submitOtp(String code, String phone) async {
    if (code.length < 4) {
      _view.onAuthError("کد تایید باید ۴ رقمی باشد");
      return;
    }
    _view.showLoading();
    final userModel = await _authService.verifyOtp(code, phone);
    _view.hideLoading();

    if (userModel != null) {
      _view.onVerificationSuccess();
    } else {
      _view.onAuthError("کد وارد شده اشتباه یا منقضی شده است");
    }
  }
}
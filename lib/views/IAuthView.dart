abstract class IAuthView {
  void showLoading();
  void hideLoading();
  void onOtpSentSuccess();
  void onVerificationSuccess();
  void onAuthError(String message);
  void _simulateAutoFill();
}
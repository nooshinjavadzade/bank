

abstract class ISplashView {
  void showLoading();
  void showSecurityError(String message);
  void navigateToLogin();
  void navigateToBiometric(); // داک گفته بعد از لاگین اول بیومتریک چک شود
}
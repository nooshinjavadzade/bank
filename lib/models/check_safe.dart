class SecurityCheckModel {
  final bool isRooted;
  final bool isEmulator;
  final bool isTampered;
  final bool isBiometricEnabled; 
  final bool isSecureStorage;    
  final bool isScreenshotBlocked;
  final String? message;

  SecurityCheckModel({
    required this.isRooted,
    required this.isEmulator,
    required this.isTampered,
    required this.isBiometricEnabled,
    required this.isSecureStorage,  
    required this.isScreenshotBlocked,
    this.message,
  });

  bool get isDeviceSafe => !isRooted && !isEmulator && !isTampered;
  String? get errorMessage {
    if (isRooted) return "گوشی شما روت شده است.";
    if (isEmulator) return "برنامه روی شبیه‌ساز اجرا نمی‌شود.";
    if (isTampered) return "نسخه برنامه دستکاری شده است.";
    return null;
  }
}
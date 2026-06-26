class AuthResponse {
  final bool success;
  final String? otpCode; 
  final String? errorMessage;

  AuthResponse({required this.success, this.otpCode, this.errorMessage});
}
import 'package:flutter/material.dart';
import '../presenter/auth_presenter.dart';
import '../widgets/otp_background.dart';
import '../widgets/otp_header.dart';
import '../widgets/otp_typography.dart';
import '../widgets/otp_box_group.dart';
import '../widgets/otp_submit_button.dart';
import '../views/IAuthView.dart';
import 'biometric_screen.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final AuthPresenter presenter;

  const OtpVerificationScreen({required this.phoneNumber, required this.presenter});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> implements IAuthView {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var node in _focusNodes) node.dispose();
    for (var controller in _controllers) controller.dispose();
    super.dispose();
  }

  String get _fullOtpCode => _controllers.map((c) => c.text).join();

  @override void showLoading() => setState(() => _isLoading = true);
  @override void hideLoading() => setState(() => _isLoading = false);
  @override void onOtpSentSuccess() {}
  
  @override
  void onVerificationSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("کد OTP تایید شد")));
    
    // ⛓️ هدایت مستقیم به صفحه بیومتریک جدید
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BiometricScreen()),
    );
  }

  @override
  void onAuthError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }
  @override
  void _simulateAutoFill() {
    // از آنجایی که در AuthService کد ۴ رقمی رندوم تولید می‌شود، 
    // در دنیای واقعی آن را از سرویس می‌خوانیم، اما برای تست داک، یک کد فرضی مثل "1234" را جایگذاری می‌کنیم.
    // (اگر می‌خواهید دقیقاً همان کد رندوم بیاید، باید یک گِتر در AuthService برای خواندن کد OTP بگذارید)
    String mockCode = "1234"; 
    
    for (int i = 0; i < _controllers.length; i++) {
      if (i < mockCode.length) {
        _controllers[i].text = mockCode[i];
      }
    }
    FocusScope.of(context).unfocus(); // بستن کیبورد پس از پر شدن
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("کد تایید به صورت خودکار جایگذاری شد (Auto Fill)"), backgroundColor: Color(0xFF516161)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      body: Stack(
        children: [
          const OtpBackground(),
          SafeArea(
            child: Column(
              children: [
                const OtpHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Image.asset('assets/images/logo.jpg', height: 80, fit: BoxFit.contain),
                        const SizedBox(height: 40),
                        const OtpTypography(),
                        const SizedBox(height: 40),
                        OtpBoxGroup(controllers: _controllers, focusNodes: _focusNodes),
                        const SizedBox(height: 40),
                        const SizedBox(height: 40),
                        const SizedBox(height: 40),
                        OtpBoxGroup(controllers: _controllers, focusNodes: _focusNodes),

                        // ✨ اضافه کردن دکمه شبیه‌ساز اوتوفیل در این بخش:
                        TextButton.icon(
                          onPressed: _simulateAutoFill,
                          icon: const Icon(Icons.flash_on, color: Color(0xFF516161)),
                          label: const Text("جایگذاری خودکار کد (Auto Fill)", style: TextStyle(color: Color(0xFF516161), fontWeight: FontWeight.bold)),
                        ),

                        const SizedBox(height: 20), // یک لایه فاصله تا دکمه اصلی
                        _isLoading 
                          ? const CircularProgressIndicator(color: Color(0xFF70585b))
                          : OtpSubmitButton(
                              onPressed: () => widget.presenter.submitOtp(_fullOtpCode, widget.phoneNumber),
                            ),

                        _isLoading 
                          ? const CircularProgressIndicator(color: Color(0xFF70585b))
                          : OtpSubmitButton(
                              onPressed: () => widget.presenter.submitOtp(_fullOtpCode, widget.phoneNumber),
                            ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
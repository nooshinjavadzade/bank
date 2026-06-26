import 'package:flutter/material.dart';
import '../presenter/auth_presenter.dart';
import '../services/auth_service.dart';
import '../widgets/login_button.dart';
import '../widgets/login_input_field.dart';
import 'IAuthView.dart';
import 'otp_verification_screen.dart'; // نام دقیق صفحه شما

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements IAuthView {
  final TextEditingController _phoneController = TextEditingController();
  late AuthPresenter _presenter;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // تزریق وابستگی سرویس به پرزنتر
    _presenter = AuthPresenter(this, AuthService());
  }

  @override void showLoading() => setState(() => _isLoading = true);
  @override void hideLoading() => setState(() => _isLoading = false);
  @override void onVerificationSuccess() {} // مربوط به این صفحه نیست

  @override
  void onOtpSentSuccess() {
    // رفتن به صفحه تایید کدی که خودت ساختی
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: _phoneController.text,
          presenter: _presenter,
        ),
      ),
    );
  }

  @override
  void onAuthError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        title: const Text("My Bank", style: TextStyle(color: Color(0xFF70585b), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            CircleAvatar(radius: 80, backgroundColor: const Color(0xFFfadadd).withOpacity(0.3)),
            const SizedBox(height: 40),
            const Text("ورود به حساب", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("شماره موبایل خود را وارد کنید", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            LoginInputField(controller: _phoneController),
            const SizedBox(height: 20),
            
            // مدیریت نمایش لودینگ یا دکمه
            _isLoading 
              ? const CircularProgressIndicator(color: Color(0xFF70585b))
              : LoginButton(onPressed: () {
                  // صدا زدن متد پرزنتر با شماره ورودی
                  _presenter.requestOtp(_phoneController.text);
                }),
            
            const Spacer(),
            Text("امن و سریع", style: TextStyle(color: Colors.grey.withOpacity(0.6))),
          ],
        ),
      ),
    );
  }
}
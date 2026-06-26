import 'package:flutter/material.dart';

class OtpTypography extends StatelessWidget {
  const OtpTypography({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "تایید شماره موبایل",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF70585b)),
        ),
        const SizedBox(height: 8),
        const Text(
          "کد ۴ رقمی ارسال شده به شماره خود را وارد کنید",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF4f4445), fontSize: 16),
        ),
      ],
    );
  }
}
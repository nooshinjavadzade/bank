import 'package:flutter/material.dart';

class OtpBackground extends StatelessWidget {
  const OtpBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -80,
      left: -80,
      child: Opacity(
        opacity: 0.2,
        child: Container(
          width: 250,
          height: 250,
          decoration: const BoxDecoration(
            color: Color(0xFFfadadd), // معادل primary-container در کلاس‌های تلویند شما
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
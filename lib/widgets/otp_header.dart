import 'package:flutter/material.dart';


class OtpHeader extends StatelessWidget {
  const OtpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF70585b)),
            onPressed: () => Navigator.maybePop(context),
          ),
          const Text(
            "My Bank",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF70585b)),
          ),
          const SizedBox(width: 48), // برای متقارن ماندن متن وسط
        ],
      ),
    );
  }
}
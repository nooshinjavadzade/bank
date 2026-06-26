import 'package:flutter/material.dart';

class OtpSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OtpSubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFfbdbde), Color(0xFFfadadd)]),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const StadiumBorder(),
          ),
          onPressed: onPressed,
          child: const Text(
            "تایید و ادامه",
            style: TextStyle(color: Color(0xFF574144), fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
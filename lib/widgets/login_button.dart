import 'package:flutter/material.dart';
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFfadadd),
          shape: StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("دریافت کد تایید", style: TextStyle(color: Color(0xFF765e61), fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.chevron_left, color: Color(0xFF765e61)),
          ],
        ),
      ),
    );
  }
}
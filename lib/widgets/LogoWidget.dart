import 'package:flutter/material.dart';
class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 8),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: ClipOval(
        child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
      ),
    );
  }
}
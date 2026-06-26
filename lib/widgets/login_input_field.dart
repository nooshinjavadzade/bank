import 'package:flutter/material.dart';
class LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  
  const LoginInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF70585b)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "۰۹۱۲-------",
          icon: Icon(Icons.smartphone, color: Colors.grey),
        ),
      ),
    );
  }
}
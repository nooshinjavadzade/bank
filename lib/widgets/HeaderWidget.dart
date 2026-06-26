import 'package:flutter/material.dart';
class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Text(
        "My Bank",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF70585b), 
          fontFamily: 'Quicksand',
        ),
      ),
    );
  }
}
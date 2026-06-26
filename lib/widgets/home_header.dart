import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "My Bank",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF70585b),
              letterSpacing: -0.02,
            ),
          ),
        ],
      ),
    );
  }
}

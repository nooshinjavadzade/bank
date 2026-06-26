import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 32, top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(112, 88, 91, 0.1),
            blurRadius: 40,
            offset: Offset(0, -10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFfadadd),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF70585b)),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(Icons.security, color: Color(0xFF626374)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SecurityToggleItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SecurityToggleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color mainColor = value ? const Color(0xFF516161) : const Color(0xFFba1a1a);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: !value ? Border.all(color: const Color(0xFFffdad6), width: 1) : null,
        boxShadow: const [
          BoxShadow(color: Color.fromRGBO(112, 88, 91, 0.05), blurRadius: 30, offset: Offset(0, 10))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: value ? const Color(0xFFd4e6e5) : const Color(0xFFffdad6),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: mainColor, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1a1c1c))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: !value ? const Color(0xFFba1a1a) : const Color(0xFF4f4445).withOpacity(0.7))),
                ],
              ),
            ],
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF516161),
            activeTrackColor: const Color(0xFFd4e6e5),
            inactiveThumbColor: const Color(0xFFba1a1a),
            inactiveTrackColor: const Color(0xFFffdad6),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
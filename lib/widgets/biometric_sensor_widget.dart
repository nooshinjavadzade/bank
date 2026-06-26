import 'package:flutter/material.dart';
import '../theme/bank_colors.dart';

class BiometricSensorWidget extends StatefulWidget {
  final VoidCallback onTap;
  const BiometricSensorWidget({required this.onTap, Key? key}) : super(key: key);

  @override
  _BiometricSensorWidgetState createState() => _BiometricSensorWidgetState();
}

class _BiometricSensorWidgetState extends State<BiometricSensorWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_controller.value * 0.05),
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: BankColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: BankColors.primaryContainer, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: BankColors.primary.withOpacity(0.1 * _controller.value),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: const Center(
                child: Icon(Icons.fingerprint, size: 96, color: BankColors.primary),
              ),
            ),
          );
        },
      ),
    );
  }
}
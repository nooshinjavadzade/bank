import 'package:flutter/material.dart';
import '../theme/bank_colors.dart';

class PinDotsWidget extends StatelessWidget {
  final int length;
  const PinDotsWidget({required this.length, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool isActive = index < length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isActive ? BankColors.primary : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: BankColors.primaryContainer, width: 2),
          ),
        );
      }),
    );
  }
}
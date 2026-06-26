import 'package:flutter/material.dart';
import '../theme/bank_colors.dart';

class NumpadWidget extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onDeletePressed;

  const NumpadWidget({required this.onKeyPressed, required this.onDeletePressed, Key? key}) : super(key: key);

  Widget _buildNumBtn(String label) {
    return InkWell(
      onTap: () => onKeyPressed(label),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 56,
        decoration: BoxDecoration(color: BankColors.surfaceContainerLow, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BankColors.primary))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        ...['۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'].map((n) => _buildNumBtn(n)),
        const SizedBox.shrink(),
        _buildNumBtn('۰'),
        IconButton(onPressed: onDeletePressed, icon: const Icon(Icons.backspace_outlined, color: BankColors.error)),
      ],
    );
  }
}
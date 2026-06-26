import 'package:flutter/material.dart';

class OtpBoxGroup extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OtpBoxGroup({required this.controllers, required this.focusNodes});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 56,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFf3f3f4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(border: InputBorder.none, counterText: ""),
              onChanged: (value) {
                if (value.length == 1 && index < 3) {
                  focusNodes[index + 1].requestFocus();
                }
                if (value.isEmpty && index > 0) {
                  focusNodes[index - 1].requestFocus();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
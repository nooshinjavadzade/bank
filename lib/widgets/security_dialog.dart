import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecurityErrorDialog extends StatelessWidget {
  final String message;

  const SecurityErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red),
          SizedBox(width: 8),
          Text("خطای امنیتی"),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          child: Text("خروج"),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../views/splash_provider.dart';
import 'package:provider/provider.dart';
class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SplashProvider>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 64.0),
      child: Column(
        children: [
          SizedBox(
            width: 128,
            child: LinearProgressIndicator(
              value: provider.progress,
              backgroundColor: Color(0xFF516161).withOpacity(0.1),
              color: Color(0xFF70585b),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "در حال تست گوشی شما...",
            style: TextStyle(fontSize: 12, color: Color(0xFF4f4445)),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  double _progress = 0.0;
  double get progress => _progress;

  void updateProgress(double value) {
    _progress = value;
    notifyListeners(); 
  }
}
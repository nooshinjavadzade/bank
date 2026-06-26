import 'package:flutter/material.dart';
import '../theme/bank_colors.dart';
import '../widgets/biometric_sensor_widget.dart';
import '../widgets/pin_dots_widget.dart';
import '../widgets/numpad_widget.dart';
import 'dart:ui';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  _BiometricScreenState createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  String _pinCode = "";

  void _showPinModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BankColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("ورود با پین", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BankColors.primary)),
                  const Text("رمز ۴ رقمی خود را وارد کنید", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 24),
                  PinDotsWidget(length: _pinCode.length),
                  const SizedBox(height: 24),
                  NumpadWidget(
                    onKeyPressed: (key) {
                      if (_pinCode.length < 4) {
                        setModalState(() => _pinCode += key);
                      }
                    },
                    onDeletePressed: () {
                      if (_pinCode.isNotEmpty) {
                        setModalState(() => _pinCode = _pinCode.substring(0, _pinCode.length - 1));
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BankColors.primary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("تایید", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BankColors.background,
      appBar: AppBar(
        title: const Text("my Bank", style: TextStyle(color: BankColors.primary, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // اورنامنت‌های بک‌گراند (بلور دایره‌ای)
          // کدی که باید جایگزین دایره قبلی شود:
          Positioned(
            top: 100,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: BankColors.primaryContainer.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40), // 🔐 ساختار درست بلور در فلاتر
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  BiometricSensorWidget(onTap: () => print("Trigger system local_auth")),
                  const SizedBox(height: 24),
                  const Text("تایید هویت", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BankColors.primary)),
                  const SizedBox(height: 8),
                  const Text("لطفاً انگشت خود را روی حسگر قرار دهید", textAlign: TextAlign.center, style: TextStyle(color: BankColors.onSurfaceVariant)),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: BankColors.surfaceContainerLow,
                      minimumSize: const Size(double.infinity, 54),
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    ),
                    onPressed: _showPinModal,
                    child: const Text("ورود با پین کد", style: TextStyle(color: BankColors.primary, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
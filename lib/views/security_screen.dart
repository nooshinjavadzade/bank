import 'package:flutter/material.dart';
import '../models/check_safe.dart';
import '../widgets/security_status_item.dart';
import '../widgets/security_toggle_item.dart';
import '../presenter/security_presenter.dart';
import '../widgets/home_bottom_nav.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> implements ISecurityView {
  late SecurityPresenter _presenter;
  SecurityCheckModel? _report;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _presenter = SecurityPresenter(this);
    _presenter.runSecurityCheck();
  }

  @override
  void showLoading() => setState(() => _isLoading = true);

  @override
  void showSecurityReport(SecurityCheckModel report) {
    setState(() {
      _report = report;
      _isLoading = false;
    });
  }

  @override
  void onError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: const Color(0xFFba1a1a)),
    );
  }

  @override
  void showStatusMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: const Color(0xFF516161)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9f9f9),
      appBar: AppBar(
        title: const Text(
          "گزارش امنیتی",
          style: TextStyle(fontFamily: 'Quicksand', color: Color(0xFF70585b), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF70585b)))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              children: [
                // ۱. تشخیص روت (ثابت)
                SecurityStatusItem(
                  title: "تشخیص روت (Root)",
                  subtitle: "امنیت دستگاه",
                  icon: Icons.shield,
                  isSafe: !_report!.isRooted,
                  passedText: "Passed",
                  failedText: "Failed",
                ),
                const SizedBox(height: 12),

                // ۲. تشخیص شبیه‌ساز (ثابت)
                SecurityStatusItem(
                  title: "تشخیص شبیه‌ساز",
                  subtitle: "یکپارچگی سخت‌افزار",
                  icon: Icons.devices,
                  isSafe: !_report!.isEmulator,
                  passedText: "Passed",
                  failedText: "Failed",
                ),
                const SizedBox(height: 12),

                // ۳. امضای اپلیکیشن (ثابت)
                SecurityStatusItem(
                  title: "امضای اپلیکیشن",
                  subtitle: "تایید اصالت نسخه",
                  icon: Icons.history_edu,
                  isSafe: !_report!.isTampered,
                  passedText: "Valid",
                  failedText: "Invalid",
                ),
                const SizedBox(height: 12),

                // ۴. بیومتریک فعال (تعاملی)
                SecurityToggleItem(
                  title: "بیومتریک فعال",
                  subtitle: "احراز هویت زیستی",
                  icon: Icons.fingerprint,
                  value: _report!.isBiometricEnabled,
                  onChanged: (val) => _presenter.toggleBiometricAuthentication(val),
                ),
                const SizedBox(height: 12),

                // ۵. فضای ذخیره امن (تعاملی)
                SecurityToggleItem(
                  title: "فضای ذخیره امن",
                  subtitle: "حفاظت از داده‌های حساس",
                  icon: Icons.vpn_key,
                  value: _report!.isSecureStorage,
                  onChanged: (val) => _presenter.toggleSecureStorage(val),
                ),
                const SizedBox(height: 12),

                // ۶. مسدودسازی اسکرین‌شات (تعاملی)
                SecurityToggleItem(
                  title: "مسدودسازی اسکرین‌شات",
                  subtitle: "ریسک حریم خصوصی",
                  icon: Icons.block,
                  value: _report!.isScreenshotBlocked,
                  onChanged: (val) => _presenter.toggleScreenshotBlocking(val),
                ),
              ],
            ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }
}
import 'package:flutter/material.dart';
import 'theme/bank_colors.dart';
import 'views/login_screen.dart';
import 'views/biometric_screen.dart';
import 'views/home_screen.dart';
// اگر صفحه اسپلش جداگانه داری، آن را اینجا ایمپورت کن، در غیر این صورت لندینگ اول صفحه لاگین خواهد بود.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloom Bank',
      debugShowCheckedModeBanner: false,
      
      // تنظیمات راست‌چین (RTL) برای زبان فارسی طبق ساختار داک و HTML
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // زبان فارسی
      ],
      locale: const Locale('fa', 'IR'),

      // تعریف تم مینی‌لب با رنگ‌های اختصاصی شما
      theme: ThemeData(
        scaffoldBackgroundColor: BankColors.background,
        primaryColor: BankColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: BankColors.primary,
          primary: BankColors.primary,
          primaryContainer: BankColors.primaryContainer,
          error: BankColors.error,
          background: BankColors.background,
        ),
        fontFamily: 'Quicksand', // تعریف فونت اصلی هماهنگ با وب
      ),

      // مشخص کردن مسیر اولیه برنامه (نقطه شروع)
      initialRoute: '/login',

      // نقشه‌برداری و تعریف مسیرها (Named Routes) طبق ساختار زنجیره‌ای داک
      routes: {
        '/login': (context) => LoginScreen(),
        '/biometric': (context) => const BiometricScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
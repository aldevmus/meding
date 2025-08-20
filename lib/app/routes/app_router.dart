import 'package:flutter/material.dart';

// 1. قم باستيراد كل الشاشات التي تريد التنقل إليها هنا
import 'package:meding_app/features/splash/presentation/splash_screen.dart';
import 'package:meding_app/features/auth/presentation/screens/login_screen.dart';
import 'package:meding_app/features/auth/presentation/screens/register_screen.dart';
import 'package:meding_app/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:meding_app/features/auth/presentation/screens/verification_success_screen.dart';
import 'package:meding_app/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  // 2. عرّف أسماء المسارات كمتغيرات ثابتة (static const)
  // هذا يمنع الأخطاء الإملائية في المستقبل
  static const String splash = '/'; // '/' عادة تكون للشاشة الأولى
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String verificationSuccess = '/verification-success';
  static const String home = '/home';

  // 3. أنشئ دالة ثابتة (static) تُرجع خريطة الـ routes
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      verifyEmail: (context) => const VerifyEmailScreen(),
      verificationSuccess: (context) => const VerificationSuccessScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}
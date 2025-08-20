import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart'; // UPDATED: تم إضافة هذا الاستيراد

// Core

import 'package:meding_app/app/core/theme/app_colors.dart';

// Features

import 'package:meding_app/features/onboarding/presentation/onboarding_screen.dart';

import 'package:meding_app/features/auth/presentation/screens/login_screen.dart';

// UPDATED: إضافة استيراد لصفحة الرئيسية التي سننشئها لاحقاً

import 'package:meding_app/features/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateUser();
  }

  // UPDATED: هذه هي الدالة الجديدة والكاملة التي تتحقق من كل الحالات

  Future<void> _navigateUser() async {
    // 1. الانتظار قليلاً لعرض الشعار

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return; // تحقق أمني

    // 2. التحقق مما إذا كانت هذه هي المرة الأولى التي يفتح فيها المستخدم التطبيق

    final prefs = await SharedPreferences.getInstance();

    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // 3. إذا كانت المرة الأولى، اذهب إلى شاشة التعريف (Onboarding)

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      // 4. إذا لم تكن المرة الأولى، تحقق من حالة تسجيل الدخول في Firebase

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // 4.1. المستخدم مسجل دخوله، اذهب إلى الشاشة الرئيسية

        // TODO: قبل الانتقال، يمكن تحميل بيانات المستخدم الأساسية هنا

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // 4.2. المستخدم غير مسجل دخوله، اذهب إلى شاشة تسجيل الدخول

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // واجهة المستخدم لم تتغير لأنها كانت ممتازة بالفعل

    final brightness = Theme.of(context).brightness;

    final systemUiOverlayStyle = brightness == Brightness.light
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svgs/meding_logo.svg', // تأكد أن المسار صحيح

                width: 150,

                colorFilter: const ColorFilter.mode(
                  AppColors.logoCyan,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Meding",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontFamily: 'Cairo',
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

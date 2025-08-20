import 'package:flutter/material.dart';

/// يحتوي هذا الملف على لوحة الألوان الكاملة للتطبيق،

/// مستخرجة مباشرة من ملف هوية التطبيق (HTML/Tailwind) لضمان الدقة الكاملة.

class AppColors {
  // --- الألوان الأساسية (هوية العلامة) ---

  static const Color primaryBlue =
      Color(0xFF3182CE); // blue-500: اللون الأساسي للأزرار والإجراءات

  static const Color primaryBlueDark = Color(0xFF1A365D); // اللون الأزرق الداكن

  static const Color primaryBlueAccent =
      Color(0xFFBEE3F8); // blue-200: للتمييز والتأثيرات

  static const Color primaryBlueLight =
      Color(0xFFEBF8FF); // blue-50: للخلفيات الفاتحة جداً

  static const Color logoCyan =
      Color(0xFF06B6D4); // cyan-500: لون الشعار الثابت

  // --- ألوان الحالات (للنجاح، التنبيه، الخطأ) ---

  static const Color success = Color(0xFF22C55E); // green-500

  static const Color warning = Color(0xFFEAB308); // yellow-500

  static const Color error = Color(0xFFEF4444); // red-500

  static const Color primaryPurple = Color(0xFFa855f7);
  // --- ألوان الوضع النهاري (Light Mode) ---

  static const Color lightBg = Color(0xFFFFFFFF);

  static const Color lightInputBg = Color(0xFFF8FAFC);

  static const Color lightBg1 = Color(0xFFE5E7EB); // white

  static const Color lightSurface = Color(0xFFF3F4F6); //gray100

  static const Color lightTextPrimary =
      Color(0xFF1F2937); // gray-800: نصوص أساسية

  static const Color lightTextSecondary =
      Color(0xFF4B5563); // gray-600: نصوص ثانوية

  static const Color lightBorder = Color(0xFFE5E7EB); // gray-200: حدود

  static const Color lightButtonSecondaryBg =
      Color(0xFFE5E7EB); // gray-200: خلفية زر ثانوي

  // --- ألوان الوضع الليلي (Dark Mode) ---

  static const Color darkBg = Color(0xFF111827); // gray-900: خلفية عامة

  static const Color darkSurface =
      Color(0xFF1F2937); // gray-800: للبطاقات والأسطح

  static const Color darkTextPrimary =
      Color(0xFFF9FAFB); // gray-50: نصوص أساسية (أبيض مائل للرمادي)

  static const Color darkTextSecondary =
      Color(0xFF9CA3AF); // gray-400: نصوص ثانوية

  static const Color darkBorder = Color(0xFF374151); // gray-700: حدود

  static const Color darkButtonSecondaryBg =
      Color(0xFF374151); // gray-700: خلفية زر ثانوي

  static const Color darkInputBg =
      Color(0xFF374151); // gray-700: خلفية حقول الإدخال
}

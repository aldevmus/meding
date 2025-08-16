import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData getTheme(String languageCode, Brightness brightness) {

    final bool isDarkMode = brightness == Brightness.dark;

    final String fontFamily = (languageCode == 'ar') ? 'Cairo' : 'Inter';

    // الألوان بناءً على الوضع

    final Color bgColor = isDarkMode ? AppColors.darkBg : AppColors.lightBg;

    final Color surfaceColor = isDarkMode ? AppColors.darkSurface : AppColors.lightSurface;

    final Color primaryTextColor = isDarkMode ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final Color secondaryTextColor = isDarkMode ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final Color borderColor = isDarkMode ? AppColors.darkBorder : AppColors.lightBorder;

    final Color buttonSecondaryBg = isDarkMode ? AppColors.darkButtonSecondaryBg : AppColors.lightButtonSecondaryBg;

    final Color inputBgColor = isDarkMode ? AppColors.darkInputBg : AppColors.lightInputBg;

    

    // بناء TextTheme ليتطابق مع دليل الهوية

    final textTheme = TextTheme(

      displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 30.0, fontWeight: FontWeight.w700, color: primaryTextColor), // H1

      displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 24.0, fontWeight: FontWeight.w700, color: primaryTextColor), // H2

      displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 20.0, fontWeight: FontWeight.w600, color: primaryTextColor),  // H3

      bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16.0, fontWeight: FontWeight.w400, color: primaryTextColor, height: 1.5), // p

      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14.0, fontWeight: FontWeight.w600, color: secondaryTextColor),     // small text

      labelLarge: TextStyle(fontFamily: fontFamily, fontSize: 16.0, fontWeight: FontWeight.w700), // Button text

    );

    return ThemeData(

      useMaterial3: true,

      brightness: brightness,

      primaryColor: AppColors.primaryBlue,

      scaffoldBackgroundColor: bgColor,

      fontFamily: fontFamily,

      colorScheme: ColorScheme(

        brightness: brightness,

        primary: AppColors.primaryBlue,

        onPrimary: Colors.white,

        secondary: AppColors.logoCyan,

        onSecondary: Colors.white,

        error: AppColors.error,

        onError: Colors.white,

        background: bgColor,

        onBackground: primaryTextColor,

        surface: surfaceColor,

        onSurface: primaryTextColor,
        
        outline:borderColor,

      ),

      textTheme: textTheme,

      

      appBarTheme: AppBarTheme(

        backgroundColor: isDarkMode ? AppColors.darkSurface.withOpacity(0.8) : AppColors.lightSurface.withOpacity(0.8),

        elevation: 0,

        scrolledUnderElevation: 0,

        surfaceTintColor: Colors.transparent,

        systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,

        titleTextStyle: textTheme.displaySmall,

        iconTheme: IconThemeData(color: primaryTextColor),

      ),

      elevatedButtonTheme: ElevatedButtonThemeData(

        style: ElevatedButton.styleFrom(

          backgroundColor: AppColors.primaryBlue,

          foregroundColor: Colors.white,

          textStyle: textTheme.labelLarge,

          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

          elevation: 0,

        ),

      ),

      outlinedButtonTheme: OutlinedButtonThemeData(

          style: OutlinedButton.styleFrom(

            backgroundColor: buttonSecondaryBg,

            foregroundColor: primaryTextColor,

            textStyle: textTheme.labelLarge,

            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),

            side: BorderSide.none,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

          )

      ),

      inputDecorationTheme: InputDecorationTheme(

        filled: true,

        fillColor: inputBgColor,

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

        hintStyle: textTheme.bodyLarge?.copyWith(color: secondaryTextColor),

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),

          borderSide: BorderSide(color: borderColor),

        ),

        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),

          borderSide: BorderSide(color: borderColor),

        ),

        focusedBorder: OutlineInputBorder( // هذا هو السلوك عند التركيز - يتطابق مع الهوية

          borderRadius: BorderRadius.circular(12),

          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),

        ),

      ),

      cardTheme: CardTheme(

        color: surfaceColor,

        elevation: 0,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(

          borderRadius: const BorderRadius.all(Radius.circular(12)),

          side: BorderSide(color: borderColor),

        ),

      ),

    );

  }

}


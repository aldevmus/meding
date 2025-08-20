import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

// ===== الويدجت الأول: القسم الرئيسي (مكتمل الآن) =====

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? AppColors.darkSurface : AppColors.primaryBlueAccent;

    final titleColor =
        isDarkMode ? AppColors.darkTextPrimary : AppColors.primaryBlueDark;

    return Container(
      // This margin adds space below the entire section

      margin: const EdgeInsets.only(bottom: 10.0),

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Courses!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: titleColor,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 185,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CourseCard(
                      title: "Anatomy Course", instructor: "Dr. Ahmed Ali"),
                  CourseCard(
                      title: "Medical Basics",
                      instructor: "Dr. Fatima Mohamed"),
                  CourseCard(title: "Pharmacology", instructor: "Dr. Omar"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ===== الويدجت الثاني: بطاقة الكورس (بالتصميم الصحيح) =====

class CourseCard extends StatelessWidget {
  final String title;

  final String instructor;

  const CourseCard({super.key, required this.title, required this.instructor});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // --- If it's dark mode, we'll show the solid dark design ---

    if (isDarkMode) {
      final cardBackgroundColor = AppColors.darkSurface;

      final borderColor = AppColors.darkBorder;

      final textColor = AppColors.darkTextPrimary;

      final subtextColor = AppColors.darkTextSecondary;

      final imagePlaceholderColor = AppColors.darkBorder;

      return Container(
        width: 192,
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 96,
                decoration: BoxDecoration(
                    color: imagePlaceholderColor,
                    borderRadius: BorderRadius.circular(8.0))),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(instructor,
                style: TextStyle(
                    fontSize: 14, color: subtextColor, fontFamily: 'Cairo'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      );
    }

    // --- Otherwise (if it's light mode), we'll show the transparent glass design ---

    else {
      final glassColor = Colors.white.withValues(alpha: 0.2);

      final borderColor = Colors.white.withValues(alpha: 0.3);

      final imagePlaceholderColor = Colors.white.withValues(alpha: 0.4);

      final textColor = const Color(0xFF1F2937);

      return Container(
        width: 192,
        margin: const EdgeInsets.only(left: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: glassColor,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 96,
                      decoration: BoxDecoration(
                          color: imagePlaceholderColor,
                          borderRadius: BorderRadius.circular(8.0))),
                  const SizedBox(height: 8),
                  Text(title,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(instructor,
                      style: TextStyle(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.8),
                          fontFamily: 'Cairo'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

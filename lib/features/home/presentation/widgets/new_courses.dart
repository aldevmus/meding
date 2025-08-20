// File: suggested_courses_section.dart

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

// ===== الويدجت الأول: القسم الرئيسي =====

class CoursesSection extends StatelessWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? AppColors.darkSurface : AppColors.primaryBlueAccent;

    final titleColor =
        isDarkMode ? AppColors.darkTextPrimary : AppColors.primaryBlueDark;

    return Container(
      // This margin adds space below the entire section

      margin: const EdgeInsets.only(bottom: 24.0),

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
              height: 185, // Height is suitable for the new card

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

// ===== الويدجت الثاني: بطاقة الكورس (بالتصميم الأصلي) =====

class CourseCard extends StatelessWidget {
  final String title;

  final String instructor;

  const CourseCard({super.key, required this.title, required this.instructor});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on the theme

    final cardBackgroundColor =
        isDarkMode ? AppColors.darkSurface : Colors.white;

    final borderColor =
        isDarkMode ? AppColors.darkBorder : const Color(0xFFE5E7EB);

    final textColor =
        isDarkMode ? AppColors.darkTextPrimary : const Color(0xFF111827);

    final subtextColor =
        isDarkMode ? AppColors.darkTextSecondary : const Color(0xFF4B5563);

    final imagePlaceholderColor =
        isDarkMode ? AppColors.darkBorder : const Color(0xFFF3F4F6);

    return Container(
      width: 192,

      margin: const EdgeInsets.only(
          left: 16.0), // For horizontal spacing between cards

      padding: const EdgeInsets.all(12.0), // Internal padding of the card

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
              borderRadius: BorderRadius.circular(8.0),
            ),

            // TODO: You can add an image here later
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            instructor,
            style: TextStyle(
              fontSize: 14,
              color: subtextColor,
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

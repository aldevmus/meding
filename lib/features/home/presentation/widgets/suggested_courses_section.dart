// File: suggested_courses_section.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

// ===== الويدجت الأول: القسم الرئيسي =====

class SuggestedCoursesSection extends StatelessWidget {

  const SuggestedCoursesSection({super.key});

  @override

  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? AppColors.darkSurface : AppColors.primaryBlueAccent;

    final titleColor = isDarkMode ? AppColors.darkTextPrimary : AppColors.primaryBlueDark;

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: backgroundColor,

        borderRadius: BorderRadius.circular(16),

      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(

            "كورسات مقترحة!",

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

                GlassmorphismCourseCard(title: "كورس التشريح", instructor: "د. أحمد علي"),

                GlassmorphismCourseCard(title: "أساسيات الطب", instructor: "د. فاطمة محمد"),

                GlassmorphismCourseCard(title: "علم الأدوية", instructor: "د. عمر"),

              ],

            ),

          )

        ],

      ),

    );

  }

}

// ===== الويدجت الثاني: بطاقة الكورس =====

class GlassmorphismCourseCard extends StatelessWidget {

  final String title;

  final String instructor;

  const GlassmorphismCourseCard({super.key, required this.title, required this.instructor});

  @override

  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final glassColor = isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.4);

    final borderColor = isDarkMode ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.5);

    final imagePlaceholderColor = isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.2);

    

    final textColor = isDarkMode ? AppColors.darkTextPrimary : const Color(0xFF111827);

    final subtextColor = isDarkMode ? AppColors.darkTextSecondary : const Color(0xFF4B5563);

    return Container(

      width: 192,
margin: const
EdgeInsets.only(left: 16.0),
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

                    borderRadius: BorderRadius.circular(8.0),

                  ),

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

          ),

        ),

      ),

    );

  }

}


import 'dart:ui'; // <<< قم بإضافة هذا السطر لاستخدام ImageFilter

import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

class LessonCard extends StatelessWidget {

  final String title;

  final String instructor;

  const LessonCard({super.key, required this.title, required this.instructor});

  @override

  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // --- ألوان معدلة للتصميم الزجاجي ---

    // الألوان أصبحت شبه شفافة

    final cardColor = isDarkMode 

        ? Colors.white.withOpacity(0.15) 

        : Colors.white.withOpacity(0.4);

        

    final borderColor = isDarkMode 

        ? Colors.white.withOpacity(0.2) 

        : Colors.white.withOpacity(0.5);

    final textColor = isDarkMode ? AppColors.darkTextPrimary : const Color(0xFF111827);

    final subtextColor = isDarkMode ? AppColors.darkTextSecondary : const Color(0xFF4B5563);

    

    // لون مكان الصورة أصبح شبه شفاف أيضاً

    final imagePlaceholderColor = isDarkMode

        ? Colors.white.withOpacity(0.1)

        : Colors.white.withOpacity(0.2);

    return SizedBox(

      width: 192,

      // التعديل الأول: استخدام ClipRRect لتطبيق الحواف الدائرية على التأثير الضبابي

      child: ClipRRect(

        borderRadius: BorderRadius.circular(12),

        child: BackdropFilter(

          // التعديل الثاني: هذا هو الفلتر الذي ينشئ التأثير الضبابي

          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),

          child: Card(

            clipBehavior: Clip.antiAlias,

            margin: const EdgeInsets.only(right: 16),

            elevation: 0,

            // التعديل الثالث: لون البطاقة أصبح شبه شفاف

            color: cardColor, 

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(12),

              side: BorderSide(color: borderColor),

            ),

            child: Padding(

              padding: const EdgeInsets.all(12.0),

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

                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(

                        title,

                        style: TextStyle(

                          color: textColor,

                          fontWeight: FontWeight.bold,

                          fontFamily: 'Cairo',

                          fontSize: 16,

                        ),

                      ),

                      const SizedBox(height: 4),

                      Text(

                        instructor,

                        style: TextStyle(

                          fontSize: 14,

                          color: subtextColor,

                          fontFamily: 'Cairo',

                        ),

                      ),

                    ],

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}


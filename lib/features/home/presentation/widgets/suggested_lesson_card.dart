import 'package:flutter/material.dart';

import'package:meding_app/app/core/theme/app_colors.dart'; // تأكد من أن هذا المسار صحيح

class SuggestedLessonCard extends StatelessWidget {

  final String title;

  final String instructor;

  const SuggestedLessonCard({super.key, required this.title, required this.instructor});

  @override

  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // --- لم تتغير هذه المتغيرات ---

    final cardColor = isDarkMode ? AppColors.darkSurface : const Color(0xFFF3F4F6);

    final borderColor = isDarkMode ? AppColors.darkBorder : const Color(0xFFE5E7EB);

    final textColor = isDarkMode ? AppColors.darkTextPrimary : const Color(0xFF111827);

    final subtextColor = isDarkMode ? AppColors.darkTextSecondary : const Color(0xFF4B5563);

    // --- لون جديد لمكان الصورة ---

    const imagePlaceholderColor = Color(0xFFD1D5DB);

    return SizedBox(

      width: 192,

      child: Card(

        clipBehavior: Clip.antiAlias,

        margin: const EdgeInsets.only(right: 16), // في وضع RTL ستكون المسافة على اليسار

        elevation: 0,

        color: cardColor,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(12), // rounded-xl

          side: BorderSide(color: borderColor),

        ),

        // التعديل الأول: تم نقل الـ Padding ليحيط بكل المحتوى

        child: Padding(

          padding: const EdgeInsets.all(12.0), // p-3

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // التعديل الثاني: تعديل حاوية الصورة

              Container(

                height: 96, // h-24

                decoration: BoxDecoration(

                  // استخدام لون التصميم في الوضع العادي

                  color: isDarkMode ? AppColors.darkBorder : imagePlaceholderColor,

                  borderRadius: BorderRadius.circular(8.0), // rounded-lg

                ),

                // TODO: Add Image.network here

              ),

              // التعديل الثالث: إضافة مسافة بين الصورة والنص

              const SizedBox(height: 8), // mb-2

              // لا حاجة لـ Padding إضافي هنا

              Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    title,

                    style: TextStyle(

                      color: textColor,

                      fontWeight: FontWeight.bold,

                      fontFamily: 'Cairo',

                      fontSize: 16, // حجم خط أنسب للعنوان

                    ),

                  ),

                  const SizedBox(height: 4),

                  // التعديل الرابع: تعديل حجم خط اسم المدرس

                  Text(

                    instructor,

                    style: TextStyle(

                      fontSize: 14, // text-sm

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

    );

  }

}


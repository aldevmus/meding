import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/app/core/utils/app_icons.dart';

class QuickNavGrid extends StatelessWidget {

  const QuickNavGrid({super.key});

  @override

  Widget build(BuildContext context) {

    // 8 عناصر كما في التصميم
      
    final items = [

      {"label": "اخبار", "svgPath": AppIcons.catNews},

      {"label": "كورسات", "svgPath": AppIcons.catCourses},

      {"label": "ملفات", "svgPath": AppIcons.catFiles},

      {"label": "دروس", "svgPath": AppIcons.catLessons},

      {"label": "بحوث", "svgPath": AppIcons.catResearch},

      {"label": "اختبارات", "svgPath": AppIcons.catTests},

      {"label": "البريد", "svgPath": AppIcons.catMail},

      {"label": "المزيد", "svgPath": AppIcons.catMore},

    ];

    return GridView.builder(
    padding: EdgeInsets.zero,
      itemCount: items.length,

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 4,

        crossAxisSpacing: 12,

        mainAxisSpacing: 12,

        childAspectRatio: 0.85, // تعديل الأبعاد لتكون أطول

      ),

      itemBuilder: (context, index) {

        final item = items[index];

        return _QuickNavItem(

          label: item["label"] as String,

          svgPath: item["svgPath"] as String,

        );

      },

    );

  }

}

class _QuickNavItem extends StatelessWidget {

  final String label;

  final String svgPath;

  const _QuickNavItem({required this.label, required this.svgPath});

  @override

  Widget build(BuildContext context) {
    
      final isDarkMode =           Theme.of(context).brightness == Brightness.dark;

 final Color bgColor = isDarkMode ? AppColors.darkBg : AppColors.lightBg;     

    return Container(

      padding: const EdgeInsets.all(8), // تقليل الحشو قليلاً

      decoration: BoxDecoration(

        color: bgColor,
        
          border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1),

        borderRadius: BorderRadius.circular(16),

      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(

              color: AppColors.primaryBlueLight, // theme-bg-100

              borderRadius: BorderRadius.circular(12),

            ),

            child: SvgPicture.asset(

              svgPath,

              height: 24,

              width: 24,

              colorFilter: const ColorFilter.mode(AppColors.primaryBlue, BlendMode.srcIn),

            ),

          ),

          const SizedBox(height: 8),

          Text(

            label,

            style: const TextStyle(

              fontSize: 12,

              fontWeight: FontWeight.w600,

             color:AppColors.primaryBlueLight,

            ),

            maxLines: 1,

            overflow: TextOverflow.ellipsis,

          ),

        ],

      ),

    );

  }

}


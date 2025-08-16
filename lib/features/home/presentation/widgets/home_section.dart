import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

class HomeSection extends StatelessWidget {

  final String title;

  final VoidCallback? onViewAll;

  final List<Widget> children;

  final bool isList;

  final double? height; // لإعطاء ارتفاع مخصص للقوائم الأفقية

  const HomeSection({

    super.key,

    required this.title,

    this.onViewAll,

    required this.children,

    this.isList = false,

    this.height,

  });

  @override

  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Padding(

          padding: const EdgeInsets.only(bottom: 12.0),

          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(

                title,

                style: const TextStyle(

                    fontSize: 20,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF1F2937)),

              ),

              if (onViewAll != null)

                TextButton(

                  onPressed: onViewAll,

                  child: const Text(

                    "عرض الكل", // سيتم ترجمته لاحقًا

                    style: TextStyle(

                      color: AppColors.primaryBlue,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

            ],

          ),

        ),

        if (isList)

          Column(children: children)

        else

          SizedBox(

            height: height ?? 150, // استخدم الارتفاع المخصص أو الافتراضي

            child: ListView(

              scrollDirection: Axis.horizontal,

              children: children,

            ),

          )

      ],

    );

  }

}


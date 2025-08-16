import 'package:flutter/material.dart';

class ExclusiveContentCard extends StatelessWidget {

  const ExclusiveContentCard({super.key});

  @override

  Widget build(BuildContext context) {

    return Container(

      width: 160,

      height: 96,

      margin: const EdgeInsets.only(right: 16),

      decoration: BoxDecoration(

        color: Theme.of(context).brightness == Brightness.dark

            ? Colors.grey.shade800

            : const Color(0xFFE5E7EB),

        borderRadius: BorderRadius.circular(12),

      ),

    );

  }

}


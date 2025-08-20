import 'package:flutter/material.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

class ActionCard extends StatelessWidget {
  final String title;

  final String subtitle;

  final String buttonText;

  final IconData icon;

  final VoidCallback onButtonPressed;

  const ActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.primaryBlue.withValues(alpha: 0.15)
          : AppColors.primaryBlue.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}

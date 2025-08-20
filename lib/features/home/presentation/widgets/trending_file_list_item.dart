import 'package:flutter/material.dart';

class TrendingFileListItem extends StatelessWidget {
  final String title;

  const TrendingFileListItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB), // bg-gray-200

                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151)),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Important: Make sure your file paths are correct for your project structure
import '../../../app/core/utils/app_icons.dart';
import '../screens/create_post_screen.dart';

class GlassmorphismAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GlassmorphismAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final glassColor = isDarkMode
        ? const Color.fromRGBO(31, 41, 55, 0.6)
        : const Color.fromRGBO(255, 255, 255, 0.6);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBar(
          title: const Text("المجتمع"),
          backgroundColor: glassColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 68,
          actions: [
            // Search Icon
            IconButton(
              onPressed: () {
                // TODO: Handle search action
              },
              icon: SvgPicture.asset(
                AppIcons.search,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
            // Create Post Button
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16.0),
              child: Material(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
                elevation: 4,
                shadowColor: theme.primaryColor.withOpacity(0.4),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePostScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppIcons.communityAdd,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "إنشاء",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}

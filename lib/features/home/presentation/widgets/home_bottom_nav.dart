// lib/features/home/presentation/widgets/home_bottom_nav.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/app/core/utils/app_icons.dart';

import 'package:meding_app/features/home/presentation/screens/home_screen.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

class HomeBottomNav extends StatelessWidget {
  final NavPage currentPage;

  final ValueChanged<NavPage> onPageSelected;

  final VoidCallback onAddTapped;

  const HomeBottomNav({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
    required this.onAddTapped,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    // --- Styling for the glass effect, border, and shadow ---

    final barColor = (isDarkMode ? AppColors.darkSurface : Colors.white)
        .withValues(alpha: 0.85);

    final borderColor = isDarkMode
        ? Colors.white.withValues(alpha: 0.15)
        : Colors.grey.shade300.withValues(alpha: 0.5);

    final shadowColor = Colors.black.withValues(alpha: 0.1);

    // --- FIX #2: The icon order is now correct for LTR languages ---

    // The `.reversed` logic will handle RTL automatically.

    final navItems = <Widget>[
      _NavItem(
        label: AppLocalizations.of(context)!.nav_home,
        svgPath: AppIcons.navHome,
        isActive: currentPage == NavPage.home,
        onTap: () => onPageSelected(NavPage.home),
      ),
      _NavItem(
        label: AppLocalizations.of(context)!.nav_forum,

        svgPath: AppIcons.search, // Using search icon

        isActive: currentPage == NavPage.forum,

        onTap: () => onPageSelected(NavPage.forum),
      ),
      _NavItem(
        label: 'ajouter',
        svgPath: AppIcons.navAdd,
        isActive: false,
        onTap: onAddTapped,
      ),
      _NavItem(
        label: AppLocalizations.of(context)!.nav_community,
        svgPath: AppIcons.navCommunity,
        isActive: currentPage == NavPage.community,
        onTap: () => onPageSelected(NavPage.community),
      ),
      _NavItem(
        label: AppLocalizations.of(context)!.nav_profile,
        svgPath: AppIcons.navProfile,
        isActive: currentPage == NavPage.profile,
        onTap: () => onPageSelected(NavPage.profile),
      ),
    ];

    // --- FIX #1: The main structure is changed to control the width and centering ---

    // We use a Row to center the floating bar horizontally.

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: shadowColor, blurRadius: 20)],
                    color: barColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: borderColor)),
                child: Row(
                  // This is the key to making the bar's width flexible and not stretched

                  mainAxisSize: MainAxisSize.min,

                  children: isRtl ? navItems.reversed.toList() : navItems,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;

  final String svgPath;

  final bool isActive;

  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.svgPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final activeBgColor = (isDarkMode
        ? AppColors.primaryBlue.withValues(alpha: 0.2)
        : AppColors.primaryBlue.withValues(alpha: 0.1));

    final activeIconAndTextColor =
        isDarkMode ? AppColors.primaryBlueAccent : AppColors.primaryBlue;

    final inactiveColor = Theme.of(context).textTheme.bodySmall?.color;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),

        // --- FIX #1: Increased height to make the bar taller ---

        height: 52,

        curve: Curves.easeInOut,

        padding: const EdgeInsets.symmetric(horizontal: 12),

        decoration: BoxDecoration(
          color: isActive ? activeBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(svgPath,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                    isActive ? activeIconAndTextColor : inactiveColor!,
                    BlendMode.srcIn)),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Row(
                children: [
                  // --- FIX #3: The logic for spacing and text visibility is simplified ---

                  SizedBox(width: isActive ? (isRtl ? 0 : 8) : 0),

                  Text(
                    isActive ? label : "",
                    style: TextStyle(
                        color: activeIconAndTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    maxLines: 1,
                  ),

                  SizedBox(width: isActive ? (isRtl ? 8 : 0) : 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

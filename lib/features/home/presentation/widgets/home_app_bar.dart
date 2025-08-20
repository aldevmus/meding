// lib/features/home/presentation/widgets/home_app_bar.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/app/core/utils/app_icons.dart';

import 'package:meding_app/l10n/generated/app_localizations.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override

  // FIX 1: The AppBar height from the HTML was 68px, kToolbarHeight is usually 56px.

  // We'll use a slightly larger height to better accommodate the content.

  Size get preferredSize => const Size.fromHeight(68.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _isSearchActive = false;

  void _setSearchActive(bool isActive) {
    setState(() {
      _isSearchActive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // This logic determines the background color based on the state.

    // It also now uses the corrected opacity value.

    Color appBarBackgroundColor;

    // FIX 2: The transparency in the HTML design was 80% (0.8 opacity).

    // I've adjusted it from 0.85 to 0.8 to match the design you want.

    const double opacity = 0.8;

    // This logic remains the same, just with the updated opacity.

    if (_isSearchActive) {
      appBarBackgroundColor = isDarkMode
          ? AppColors.darkSurface.withValues(alpha: opacity)
          : Colors.white.withValues(alpha: opacity);
    } else {
      // NOTE: You might want a different color here when not scrolling.

      // For now, it respects your original logic.

      appBarBackgroundColor =
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: opacity);
    }

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 4, sigmaY: 4), // A blur of 10 is good for 'sm'

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: appBarBackgroundColor,
          child: SafeArea(
            // Use SafeArea to avoid content overlapping with notches/status bar

            bottom: false, // We only need padding at the top

            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _isSearchActive ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                      ignoring: _isSearchActive,
                      child: _buildMainAppBar(context)),
                ),
                AnimatedOpacity(
                  opacity: _isSearchActive ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                      ignoring: !_isSearchActive,
                      child: _buildSearchView(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 16.0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svgs/meding_logo.svg",
            height: 36,
            colorFilter: ColorFilter.mode(AppColors.logoCyan, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          const Text('Meding',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            onPressed: () => _setSearchActive(true),
            iconSize: 36,
            icon: SvgPicture.asset(
              AppIcons.search,
              height: 28,
              width: 28,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // FIX 3: The search view has been completely rebuilt for proper alignment.

  Widget _buildSearchView(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // By returning an AppBar, we guarantee the search field and button

    // align perfectly, just like the main AppBar's title and actions.

    return AppBar(
      backgroundColor: Colors.transparent,

      elevation: 0,

      // The TextField now sits perfectly in the 'title' slot.

      title: TextField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: localizations.search_placeholder,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
        ),
      ),

      // The cancel button sits perfectly in the 'actions' slot.

      actions: [
        TextButton(
          onPressed: () => _setSearchActive(false),
          child: Text(localizations.cancel_button),
        ),

        const SizedBox(width: 8), // Some padding for the button
      ],
    );
  }
}

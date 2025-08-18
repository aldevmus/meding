import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/app/core/utils/app_icons.dart';

import 'package:meding_app/features/profile/presentation/models/user_profile.dart';

class ProfileSliverAppBar extends StatelessWidget {

  final UserProfile user;

  final bool isMyProfile;

  const ProfileSliverAppBar({

    super.key,

    required this.user,

    required this.isMyProfile,

  });

  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = Theme.of(context).textTheme.bodyLarge?.color;
    // this is the semi-transparent color for the glass effect
    final glassColor = (isDarkMode ? AppColors.darkSurface : Colors.white).withValues(alpha: 0.85);
    // This is the AppBar that will always stay at the top.

    return SliverAppBar(

      pinned: true, // This is what makes it stick to the top.

      elevation: 0,

      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),

      centerTitle: true,

      // The back button only appears when viewing another person's profile.

      leading: isMyProfile

          ? null

          : IconButton(

              icon: SvgPicture.asset(AppIcons.arrowLeft, colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn)),

              onPressed: () => Navigator.of(context).pop(),

            ),

      title: Text(

        isMyProfile ? "My Profile" : user.name,

        style: TextStyle(

          fontFamily: 'Cairo',

          fontWeight: FontWeight.bold,

          color: iconColor,

        ),

      ),

      actions: _buildActions(context, iconColor),
         // 'flexibleSpace' is where the background is defined
         flexibleSpace: ClipRRect(
           child: BackdropFilter(
            filter:
            ImageFilter.blur(sigmaX: 15, sigmaY: 15), // the blur effect
               child: Container(
                color: glassColor, // the semi-transparent color
               ),

           )    
         ),
    ); 

  }

  List<Widget>? _buildActions(BuildContext context, Color? iconColor) {

    if (isMyProfile) {

      if (user.userType == 'publisher') {

        return [

          IconButton(

            icon: SvgPicture.asset(AppIcons.navAdd, colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn)),

            onPressed: () {},

          ),

          IconButton(

            icon: SvgPicture.asset(AppIcons.settings, colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn)),

            onPressed: () {},

          ),

          const SizedBox(width: 8),

        ];

      } else { // This is the student's own profile

        return [

          IconButton(

            icon: SvgPicture.asset(AppIcons.settings, colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn)),

            onPressed: () {},

          ),

          const SizedBox(width: 8),

        ];

      }

    }

    return null; // No actions when viewing someone else's profile

  }

}


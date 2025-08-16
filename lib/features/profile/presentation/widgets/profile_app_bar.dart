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

    final iconColor = Theme.of(context).textTheme.bodyLarge?.color;

    

    // This is the AppBar that will always stay at the top.

    return SliverAppBar(

      pinned: true, // This is what makes it stick to the top.

      elevation: 0,

      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),

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


import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:meding_app/app/core/theme/app_colors.dart';

import 'package:meding_app/app/core/utils/app_icons.dart';

import '../models/user_profile.dart';

// Main widget to switch between header types

class ProfileHeader extends StatelessWidget {
  final UserProfile user;

  final bool isMyProfile;

  const ProfileHeader(
      {super.key, required this.user, required this.isMyProfile});

  @override
  Widget build(BuildContext context) {
    return user.userType == 'publisher'
        ? _PublisherHeader(user: user, isMyProfile: isMyProfile)
        : _StudentHeader(user: user, isMyProfile: isMyProfile);
  }
}

// --- WIDGETS FOR PUBLISHER PROFILE ---

class _PublisherHeader extends StatelessWidget {
  final UserProfile user;

  final bool isMyProfile;

  const _PublisherHeader({required this.user, required this.isMyProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.8),
                child: const CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(
                      "https://placehold.co/96x96/4299E1/FFFFFF?text=Y"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: "24", label: "Content"),
                      _StatItem(value: "15.7K", label: "Learners"),
                      _StatItem(value: "4.8 ★", label: "Rating"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(user.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      if (user.isVerified)
                        SvgPicture.asset(AppIcons.verifiedBadge, height: 20),
                    ],
                  ),
                  Text("ID: ${user.id}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              _LevelBadge(level: 25, userType: 'publisher'),
            ],
          ),
          if (isMyProfile) ...[
            const SizedBox(height: 8),
            _XpBar(currentXp: 500, requiredXp: 2000, label: "Level Details"),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              RoleBadge(
                  label: "Teacher",
                  svgPath: AppIcons.roleTeacher,
                  color: AppColors.primaryBlue),
              RoleBadge(
                  label: "Premium",
                  svgPath: AppIcons.rolePremium,
                  color: AppColors.primaryPurple),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Professor at the Faculty of Medicine, specializing in anatomy and neurology. I share files and lessons here to help students excel.",
            style: TextStyle(color: Colors.black87, height: 1.5),
          ),
          const SizedBox(height: 16),
          if (isMyProfile)
            _StyledButton(
              text: "Edit Profile",
              onPressed: () {},
              type: 'tertiary',
            )
          else
            Row(
              children: [
                Expanded(
                    child: _StyledButton(
                        text: "Follow", onPressed: () {}, type: 'primary')),
                const SizedBox(width: 8),
                Expanded(
                    child: _StyledButton(
                        text: "Message", onPressed: () {}, type: 'secondary')),
              ],
            ),
        ],
      ),
    );
  }
}

// --- WIDGETS FOR STUDENT PROFILE ---

class _StudentHeader extends StatelessWidget {
  final UserProfile user;

  final bool isMyProfile;

  const _StudentHeader({required this.user, required this.isMyProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primaryPurple,
                child: CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(
                      "https://placehold.co/96x96/8B5CF6/FFFFFF?text=A"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: "35", label: "Saved"),
                      _StatItem(value: "5", label: "Courses"),
                      _StatItem(value: "12", label: "Following"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("ID: ${user.id}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
              _LevelBadge(level: 15, userType: 'student'),
            ],
          ),
          const SizedBox(height: 8),
          _XpBar(currentXp: 80, requiredXp: 400, label: "Level 15"),
          const SizedBox(height: 16),
          if (isMyProfile)
            _StyledButton(
              text: "Edit Profile",
              onPressed: () {},
              type: 'tertiary',
            )
        ],
      ),
    );
  }
}

// --- HELPER WIDGETS (All included) ---

class RoleBadge extends StatelessWidget {
  final String label;

  final String svgPath;

  final Color color;

  const RoleBadge(
      {super.key,
      required this.label,
      required this.svgPath,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(svgPath,
              height: 14,
              width: 14,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;

  final String label;

  const _StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;

  final String userType;

  const _LevelBadge({super.key, required this.level, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            userType == 'publisher'
                ? AppIcons.levelPublisher
                : AppIcons.levelStudent,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 6),
          Text("LVL $level",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
        ],
      ),
    );
  }
}

class _XpBar extends StatelessWidget {
  final int currentXp;

  final int requiredXp;

  final String label;

  const _XpBar(
      {super.key,
      required this.currentXp,
      required this.requiredXp,
      required this.label});

  @override
  Widget build(BuildContext context) {
    final double progress = (currentXp / requiredXp).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
            Text("$currentXp / $requiredXp XP",
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
          ),
        ),
      ],
    );
  }
}

class _StyledButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final String type; // 'primary', or 'secondary', or 'tertiary'

  const _StyledButton({
    required this.text,
    required this.onPressed,
    this.type = 'primary',
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;
    switch(type){
      case 'secondary': //for "message" button
        backgroundColor = isDarkMode ? AppColors.darkSurface : Colors.grey.shade200;
        textColor = isDarkMode ? AppColors.darkTextPrimary : Colors.grey.shade800;
        break;

      case 'tertiary' : //for "edit profile" button
        backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.1);
        textColor = AppColors.primaryBlue;
        break;

      default: // Primary for "follow" button
        backgroundColor = AppColors.primaryBlue;
        textColor = Colors.white;


    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Cairo'),
      ),
      child: Text(text),
    );
  }
}

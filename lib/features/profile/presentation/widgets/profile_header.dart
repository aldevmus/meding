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
                backgroundColor: AppColors.primaryBlue,
                child: const Text("Y",
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: "24", label: "محتوى"),
                      _StatItem(value: "15.7K", label: "متعلم"),
                      _StatItem(value: "4.8", label: "تقييم"),
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
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                      const SizedBox(width: 8),
                      if (user.isVerified)
                        SvgPicture.asset(AppIcons.verifiedBadge, height: 20),
                    ],
                  ),
                  Text("ID: ${user.id}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Cairo')),
                ],
              ),
              _LevelBadge(level: 25, userType: 'publisher'),
            ],
          ),
          if (isMyProfile) ...[
            const SizedBox(height: 8),
            _XpBar(currentXp: 500, requiredXp: 2000, label: "تفاصيل المستوى"),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              RoleBadge(
                  label: "أستاذ",
                  svgPath: AppIcons.roleTeacher,
                  color: AppColors.primaryBlue),
              RoleBadge(
                  label: "مميز",
                  svgPath: AppIcons.rolePremium,
                  color: AppColors.primaryPurple),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "أستاذ في كلية الطب، متخصص في علم التشريح والأعصاب. أشارك هنا ملفات ودروس لمساعدة الطلاب على التفوق.",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.5,
                fontFamily: 'Cairo',
                fontSize: 15),
          ),
          const SizedBox(height: 16),
          if (isMyProfile)
            _StyledButton(
              text: "تعديل الملف الشخصي",
              onPressed: () {},
              type: 'tertiary',
            )
          else
            Row(
              children: [
                Expanded(
                    child: _StyledButton(
                        text: "متابعة", onPressed: () {}, type: 'primary')),
                const SizedBox(width: 8),
                Expanded(
                    child: _StyledButton(
                        text: "مراسلة", onPressed: () {}, type: 'secondary')),
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
                child: Text("A",
                    style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: "35", label: "تم حفظه"),
                      _StatItem(value: "5", label: "كورسات"),
                      _StatItem(value: "12", label: "متابَع"),
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo')),
                  Text("ID: ${user.id}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Cairo')),
                ],
              ),
              _LevelBadge(level: 15, userType: 'student'),
            ],
          ),
          const SizedBox(height: 8),
          _XpBar(currentXp: 80, requiredXp: 400, label: "المستوى 15"),
          const SizedBox(height: 16),
          if (isMyProfile)
            _StyledButton(
              text: "تعديل الملف الشخصي",
              onPressed: () {},
              type: 'tertiary',
            )
        ],
      ),
    );
  }
}

// --- HELPER WIDGETS ---

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
          color: color.withValues(alpha: 0.1),
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
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  fontFamily: 'Cairo')),
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
    final textTheme = Theme.of(context).textTheme;

    if (label == "تقييم") {
      return Column(
        children: [
          RichText(
            text: TextSpan(
              style: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              children: [
                TextSpan(text: value),
                const TextSpan(
                    text: " ★",
                    style: TextStyle(color: Colors.amber, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(label,
              style: textTheme.bodySmall
                  ?.copyWith(color: Colors.grey.shade600, fontFamily: 'Cairo')),
        ],
      );
    } else {
      return Column(
        children: [
          Text(value,
              style: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
          const SizedBox(height: 2),
          Text(label,
              style: textTheme.bodySmall
                  ?.copyWith(color: Colors.grey.shade600, fontFamily: 'Cairo')),
        ],
      );
    }
  }
}

class _LevelBadge extends StatelessWidget {
  final int level;
  final String userType;

  const _LevelBadge({super.key, required this.level, required this.userType});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerLow
              .withValues(alpha: 0.6),
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
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 6),
          Text("LVL $level",
              style:
                  textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
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
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'Cairo')),
            Text("$currentXp / $requiredXp XP",
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 8,
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerLow
                .withValues(alpha: 0.6),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String type;

  const _StyledButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.type = 'primary'});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;

    switch (type) {
      case 'secondary':
        backgroundColor =
            isDarkMode ? AppColors.darkSurface : Colors.grey.shade200;
        textColor =
            isDarkMode ? AppColors.darkTextPrimary : Colors.grey.shade800;
        break;
      case 'tertiary':
        backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.1);
        textColor = AppColors.primaryBlue;
        break;
      default: // primary
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Cairo'),
      ),
      child: Text(text),
    );
  }
}

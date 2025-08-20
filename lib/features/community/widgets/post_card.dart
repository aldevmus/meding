import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Important: Make sure your file paths are correct for your project structure
import '../../../app/core/utils/app_icons.dart';
import 'package:meding_app/app/core/theme/app_colors.dart';
import '../models/post_model.dart';
import 'comments_bottom_sheet.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final glassColor = isDarkMode
        ? const Color.fromRGBO(31, 41, 55, 0.6)
        : const Color.fromRGBO(255, 255, 255, 0.6);
    final glassBorderColor = isDarkMode
        ? const Color.fromRGBO(55, 65, 81, 0.2)
        : const Color.fromRGBO(255, 255, 255, 0.2);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: glassBorderColor),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostHeader(theme, context),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: theme.textTheme.displaySmall?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              if (post.imageUrl != null) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    post.imageUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Divider(color: glassBorderColor.withOpacity(0.5), height: 1),
              const SizedBox(height: 8),
              _buildPostFooter(theme, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostHeader(ThemeData theme, BuildContext context) {
    final Color tagColor =
        (post.authorRole == "أستاذ") ? AppColors.error : AppColors.primaryBlue;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(post.authorAvatarUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.authorName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (post.isVerified) ...[
                    const SizedBox(width: 4),
                    SvgPicture.asset(AppIcons.verifiedBadge,
                        width: 16, height: 16),
                  ]
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  post.authorRole,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: tagColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (post.isPremium)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.communityPremium,
                    colorFilter: const ColorFilter.mode(
                        AppColors.warning, BlendMode.srcIn),
                    width: 12,
                    height: 12),
                const SizedBox(width: 4),
                Text(
                  "متميز",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.warning,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPostFooter(ThemeData theme, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _footerButton(theme, AppIcons.communityLike, post.likes.toString(),
                onTap: () {}),
            const SizedBox(width: 24),
            _footerButton(
                theme, AppIcons.communityComment, post.comments.toString(),
                onTap: () {
              showCommentsBottomSheet(context);
            }),
          ],
        ),
        Text(
          post.timestamp,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _footerButton(ThemeData theme, String icon, String count,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface.withOpacity(0.7),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              count,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

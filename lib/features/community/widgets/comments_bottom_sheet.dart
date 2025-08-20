import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Important: Make sure your file paths are correct for your project structure
import '../../../app/core/utils/app_icons.dart';

void showCommentsBottomSheet(BuildContext context) {
  final theme = Theme.of(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildHeader(context, theme),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: 10,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => _CommentItem(index: index),
                  ),
                ),
                _buildCommentInputField(context, theme),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildHeader(BuildContext context, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 40),
        Text("التعليقات (23)",
            style: theme.textTheme.displaySmall?.copyWith(fontSize: 18)),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

Widget _buildCommentInputField(BuildContext context, ThemeData theme) {
  return Padding(
    padding: EdgeInsets.only(
      top: 8,
      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "أضف تعليقاً...",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: theme.colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: theme.colorScheme.outline),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: theme.primaryColor,
          child: IconButton(
            icon: SvgPicture.asset(
              AppIcons.communitySend,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

class _CommentItem extends StatelessWidget {
  final int index;
  const _CommentItem({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://placehold.co/40x40/2B6CB0/FFFFFF?text=${index + 1}'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("أحمد بن علي",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface)),
              const SizedBox(height: 4),
              Text(
                "أعتقد أنه قد يكون التهاب رئوي خلالي. هل تم أخذ خزعة؟",
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

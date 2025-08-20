import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Important: Make sure your file paths are correct for your project structure
import '../../../app/core/utils/app_icons.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final List<String> _categories = [
    "علم الأمراض",
    "جراحة",
    "سؤال",
    "نقاش",
    "حالة سريرية"
  ];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء منشور"),
        backgroundColor: theme.colorScheme.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(theme,
                  label: "العنوان", hint: "اكتب عنواناً واضحاً لمنشورك..."),
              const SizedBox(height: 24),
              _buildTextField(theme,
                  label: "المحتوى",
                  hint: "اكتب تفاصيل منشورك هنا...",
                  maxLines: 8),
              const SizedBox(height: 24),
              _buildCategorySelector(theme),
              const SizedBox(height: 24),
              _buildImageUpload(theme),
              const SizedBox(height: 32),
              _buildActionButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("التصنيف",
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : null;
                });
              },
              selectedColor: theme.primaryColor,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
              ),
              backgroundColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    color: isSelected
                        ? theme.primaryColor
                        : theme.colorScheme.outline),
              ),
              showCheckmark: false,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(ThemeData theme,
      {required String label, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }

  Widget _buildImageUpload(ThemeData theme) {
    final iconColor = theme.colorScheme.onSurface.withOpacity(0.5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("إرفاق صورة (اختياري)",
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: theme.colorScheme.outline,
            strokeWidth: 2,
            radius: const Radius.circular(12),
            dashPattern: const [8, 4],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.communityImageUpload,
                  width: 48,
                  height: 48,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      const TextSpan(text: "اسحب وأفلت الصورة هنا أو "),
                      TextSpan(
                        text: "تصفح",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text("حفظ كمسودة"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("نشر"),
          ),
        ),
      ],
    );
  }
}

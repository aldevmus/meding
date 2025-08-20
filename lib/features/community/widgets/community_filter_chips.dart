import 'dart:ui';
import 'package:flutter/material.dart';

class CommunityFilterChips extends StatefulWidget {
  const CommunityFilterChips({super.key});

  @override
  State<CommunityFilterChips> createState() => _CommunityFilterChipsState();
}

class _CommunityFilterChipsState extends State<CommunityFilterChips> {
  // State for primary filters
  int _selectedPrimaryFilter = 0;
  final List<String> _primaryFilters = ["الأحدث", "الرائج", "أتابعه"];

  // ✅ State for secondary category filters
  int? _selectedCategoryFilter;
  final List<String> _categoryFilters = ["طب", "صيدلة", "طب أسنان", "تمريض", "نقاش"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPrimaryFilters(),
        const SizedBox(height: 12), // Space between the two filter rows
        _buildCategoryFilters(), // ✅ The secondary filters are back
      ],
    );
  }

  Widget _buildPrimaryFilters() {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final glassColor = isDarkMode
        ? const Color.fromRGBO(31, 41, 55, 0.6)
        : const Color.fromRGBO(255, 255, 255, 0.6);
    final glassBorderColor = isDarkMode
        ? const Color.fromRGBO(55, 65, 81, 0.2)
        : const Color.fromRGBO(255, 255, 255, 0.2);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: glassBorderColor),
          ),
          child: Row(
            children: List.generate(_primaryFilters.length, (index) {
              final isSelected = _selectedPrimaryFilter == index;
              return Expanded(
                child: Material(
                  color: isSelected ? theme.colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  elevation: isSelected ? 4 : 0,
                  shadowColor: isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() => _selectedPrimaryFilter = index),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          _primaryFilters[index],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? theme.primaryColor
                                : theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // ✅ This function builds the scrollable category chips
  Widget _buildCategoryFilters() {
    final theme = Theme.of(context);
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryFilters.length,
        // Removes the overscroll glow for a cleaner look
        physics: const BouncingScrollPhysics(), 
        clipBehavior: Clip.none, // Allows shadows to render outside the box
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryFilter == index;
          return ChoiceChip(
            label: Text(_categoryFilters[index]),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedCategoryFilter = selected ? index : null;
              });
            },
            selectedColor: theme.colorScheme.surface,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? theme.primaryColor : theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  color: isSelected ? theme.primaryColor : Colors.transparent),
            ),
            elevation: isSelected ? 2 : 0,
            shadowColor: Colors.black.withOpacity(0.1),
            showCheckmark: false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          );
        },
      ),
    );
  }
}
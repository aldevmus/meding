import 'dart:ui';
import 'package:flutter/material.dart';

class CommunityFilterChips extends StatefulWidget {
  const CommunityFilterChips({super.key});

  @override
  State<CommunityFilterChips> createState() => _CommunityFilterChipsState();
}

class _CommunityFilterChipsState extends State<CommunityFilterChips> {
  int _selectedPrimaryFilter = 0;
  final List<String> _primaryFilters = ["الأحدث", "الرائج", "أتابعه"];

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
                  color: isSelected
                      ? theme.colorScheme.surface
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  elevation: isSelected ? 4 : 0,
                  shadowColor: isSelected
                      ? Colors.black.withOpacity(0.1)
                      : Colors.transparent,
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
}

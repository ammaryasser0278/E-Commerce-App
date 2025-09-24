import 'package:flutter/material.dart';

/// Widget for displaying category filter chips
class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'All', 'value': 'all'},
      {'label': 'Protein', 'value': 'protein'},
      {'label': 'Creatine', 'value': 'creatine'},
      {'label': 'Vitamins', 'value': 'vitamins'},
      {'label': 'Omega', 'value': 'omega'},
      {'label': 'Pre-Workout', 'value': 'pre-workout'},
    ];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories
            .map(
              (category) =>
                  _buildCategoryChip(category['label']!, category['value']!),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value) {
    final isSelected = selectedCategory == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) => onCategorySelected(value),
        selectedColor: Colors.green[100],
        checkmarkColor: Colors.green[700],
        labelStyle: TextStyle(
          color: isSelected ? Colors.green[700] : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

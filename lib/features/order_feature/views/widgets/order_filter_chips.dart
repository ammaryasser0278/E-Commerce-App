import 'package:flutter/material.dart';

/// Widget for displaying order status filter chips
class OrderFilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const OrderFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'label': 'All', 'value': 'all'},
      {'label': 'Delivered', 'value': 'delivered'},
      {'label': 'Shipped', 'value': 'shipped'},
      {'label': 'Processing', 'value': 'processing'},
      {'label': 'Cancelled', 'value': 'cancelled'},
    ];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters
            .map(
              (filter) => _buildFilterChip(filter['label']!, filter['value']!),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) => onFilterSelected(value),
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

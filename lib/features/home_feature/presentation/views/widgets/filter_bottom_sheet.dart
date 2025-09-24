import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(String sortBy, String category) onApplyFilter;

  const FilterBottomSheet({super.key, required this.onApplyFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedSort = 'popularity';
  String selectedCategory = 'all';

  final List<Map<String, String>> sortOptions = [
    {'value': 'popularity', 'label': 'Most Popular'},
    {'value': 'price_low', 'label': 'Price: Low to High'},
    {'value': 'price_high', 'label': 'Price: High to Low'},
    {'value': 'rating', 'label': 'Highest Rated'},
    {'value': 'newest', 'label': 'Newest First'},
  ];

  final List<Map<String, String>> categories = [
    {'value': 'all', 'label': 'All Products'},
    {'value': 'protein', 'label': 'Protein'},
    {'value': 'vitamins', 'label': 'Vitamins'},
    {'value': 'minerals', 'label': 'Minerals'},
    {'value': 'herbs', 'label': 'Herbal Supplements'},
    {'value': 'sports', 'label': 'Sports Nutrition'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter & Sort',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSort = 'popularity';
                            selectedCategory = 'all';
                          });
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Sort Options
                  const Text(
                    'Sort By',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...sortOptions.map(
                    (option) => RadioListTile<String>(
                      title: Text(option['label']!),
                      value: option['value']!,
                      groupValue: selectedSort,
                      onChanged: (value) {
                        setState(() {
                          selectedSort = value!;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Categories
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...categories.map(
                    (category) => RadioListTile<String>(
                      title: Text(category['label']!),
                      value: category['value']!,
                      groupValue: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Apply Button - Fixed at bottom
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilter(selectedSort, selectedCategory);
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

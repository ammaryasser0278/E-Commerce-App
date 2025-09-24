import 'package:flutter/material.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/product_card.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/stat_card.dart';

/// Products tab for seller dashboard with product management
class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Stats
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total Products',
                  value: '156',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Low Stock',
                  value: '8',
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Out of Stock',
                  value: '3',
                  color: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Products List
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to add product
                },
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ..._getProducts().map((product) => ProductCard(product: product)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getProducts() {
    return [
      {'name': 'Whey Protein Powder', 'stock': 25, 'price': '29.99'},
      {'name': 'Multivitamin Complex', 'stock': 8, 'price': '19.99'},
      {'name': 'Omega-3 Fish Oil', 'stock': 0, 'price': '24.99'},
      {'name': 'Vitamin D3', 'stock': 45, 'price': '14.99'},
      {'name': 'Creatine Monohydrate', 'stock': 5, 'price': '22.99'},
    ];
  }
}

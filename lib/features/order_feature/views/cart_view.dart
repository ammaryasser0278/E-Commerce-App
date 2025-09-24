import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';
import 'package:supplements_app/core/common_widgets/leading_button.dart';
import 'package:supplements_app/core/utils/images_handling.dart';

class CartView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const CartView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final double total = items.fold<double>(0.0, (sum, item) {
      final priceString = (item['price'] ?? '0').toString();
      final numeric =
          double.tryParse(priceString.replaceAll(RegExp(r'[^0-9\.]'), '')) ??
          0.0;
      return sum + numeric;
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTitle(title: 'Cart'),
        leading: LeadingButton(),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                final String name = (item['name'] ?? '').toString();
                final String image = (item['image'] ?? item['imageUrl'] ?? '')
                    .toString();
                final String price = (item['price'] ?? '').toString();
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ImagesHandling(
                      src: image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(price),
                  trailing: const Icon(Icons.check, color: Colors.green),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: items.isEmpty
                  ? null
                  : () {
                      context.push(
                        '/payment',
                        extra: {'total': total, 'items': items},
                      );
                    },
              icon: const Icon(Icons.payment),
              label: const Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

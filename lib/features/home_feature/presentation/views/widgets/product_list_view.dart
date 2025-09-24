import 'package:flutter/material.dart';
import 'package:supplements_app/core/utils/images_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';

/// Widget for displaying products in a list layout
class ProductListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onProductTap;

  const ProductListView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final String id = (product['id'] ?? index).toString();
        final String name = (product['name'] ?? '').toString();
        final String image = (product['image'] ?? product['img'] ?? '')
            .toString();
        final double rating = product['rating'] is int
            ? (product['rating'] as int).toDouble()
            : (product['rating'] is double)
            ? (product['rating'] as double)
            : 0.0;
        final String priceText = product['price'] is num
            ? (product['price'] as num).toString()
            : (product['price'] ?? '').toString();
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 7,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListViewCard(
            onProductTap: onProductTap,
            product: product,
            id: id,
            image: image,
            name: name,
            rating: rating,
            priceText: priceText,
          ),
        );
      },
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required this.onProductTap,
    required this.product,
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
    required this.priceText,
  });

  final Function(Map<String, dynamic> p1) onProductTap;
  final Map<String, dynamic> product;
  final String id;
  final String image;
  final String name;
  final double rating;
  final String priceText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onProductTap(product);
      },
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: 'product_$id',
                  child: ImagesHandling(
                    src: image,
                    height: 96,
                    width: 96,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[600], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    priceText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),

            // Add to Cart Button
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  context.read<CartCubit>().addItem(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Added to cart'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green[600],
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

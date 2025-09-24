import 'package:flutter/material.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';

/// Widget for displaying products in a grid layout
class ProductGridView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onProductTap;

  const ProductGridView({
    super.key,
    required this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.69,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
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
        return ProductCard(
          name: name,
          price: priceText,
          image: image,
          rating: rating,
          heroTag: 'product_${product['id'] ?? index}',
          onTap: () {
            onProductTap(product);
            // Navigation will be handled in HomeView after mapping to Product
          },
          onAddToCart: () {
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
        );
      },
    );
  }
}

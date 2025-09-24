import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';
import 'package:supplements_app/core/common_widgets/leading_button.dart';
import 'package:supplements_app/core/utils/images_handling.dart';
import 'package:supplements_app/features/home_feature/data/product_model.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  final Product? product;
  const ProductDetailsView({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: AppBarTitle(title: product?.name ?? 'Product'),
        leading: LeadingButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: 'product_${product?.id ?? product?.name ?? 'hero'}',
                      child: ImagesHandling(src: product?.image ?? ''),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Product Name
              Text(
                product?.name ?? '-',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  letterSpacing: 0.3,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 12),
              // Price
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Text(
                      product != null
                          ? '\$${product!.price.toStringAsFixed(2)}'
                          : '- ',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Rating
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < ((product?.rating ?? 0).round())
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                  SizedBox(width: 8),
                  Text(
                    (product?.rating ?? 0).toStringAsFixed(1),
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Description
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        product?.desc ?? '-',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 36),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: CustomButton(
          onPressed: () {
            if (product == null) return;

            final productMap = {
              'id': product!.id,
              'name': product!.name,
              'price': product!.price,
              'image': product!.image,
              'rating': product!.rating,
              'desc': product!.desc,
            };

            context.read<CartCubit>().addItem(productMap);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added to cart'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green[600],
                duration: const Duration(seconds: 1),
              ),
            );

            context.push('/cart');
          },
          text: 'Add to Cart',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supplements_app/features/home_feature/data/product_model.dart';
import 'package:supplements_app/features/home_feature/data/product_repository.dart';
import 'package:supplements_app/features/home_feature/presentation/view_models/product_cubit.dart';
import 'package:supplements_app/core/common_widgets/shimmer_product_skeleton.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/search_bar.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/filter_bottom_sheet.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/home_app_bar.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/category_chips.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/product_grid_view.dart';
import 'package:supplements_app/features/home_feature/presentation/views/widgets/product_list_view.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController searchController = TextEditingController();
  bool isGridView = true;
  String currentSort = 'popularity';
  String currentCategory = 'all';

  late final ProductRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = ProductRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: HomeAppBar(
        isGridView: isGridView,
        onToggleView: () {
          setState(() {
            isGridView = !isGridView;
          });
        },
        onShowFilter: _showFilterBottomSheet,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // Category Chips
          CategoryChips(
            selectedCategory: currentCategory,
            onCategorySelected: (category) {
              setState(() {
                currentCategory = category;
              });
            },
          ),

          const SizedBox(height: 16),
          // Products Grid/List
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => ProductCubit(_repository)..initialize(),
                ),
              ],
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state.status == ProductStatus.loading ||
                      state.status == ProductStatus.initial) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ShimmerProductSkeleton(isGrid: isGridView),
                    );
                  }
                  if (state.status == ProductStatus.error) {
                    return Center(
                      child: Text(
                        'Failed to load products',
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    );
                  }
                  final List<Map<String, dynamic>> uiProducts = state.products
                      .map(
                        (p) => {
                          'id': p.id,
                          'name': p.name,
                          'price': '\$${p.price.toStringAsFixed(2)}',
                          'image': p.image,
                          'imageUrl': p.image,
                          'rating': p.rating,
                          'desc': p.desc,
                        },
                      )
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: isGridView
                        ? ProductGridView(
                            products: uiProducts,
                            onProductTap: (map) {
                              final product = state.products.firstWhere(
                                (p) => p.id == map['id'],
                                orElse: () => Product(
                                  id: map['id'],
                                  image: map['imageUrl'],
                                  name: map['name'],
                                  price:
                                      double.tryParse(
                                        map['price'].toString().replaceAll(
                                          RegExp(r'[^0-9\.]'),
                                          '',
                                        ),
                                      ) ??
                                      0,
                                  rating: map['rating'] ?? 0,
                                  desc: map['desc'] ?? '',
                                ),
                              );
                              context.push('/product-details', extra: product);
                            },
                          )
                        : ProductListView(
                            products: uiProducts,
                            onProductTap: (map) {
                              final product = state.products.firstWhere(
                                (p) => p.id == map['id'],
                                orElse: () => Product(
                                  id: map['id'],
                                  image: map['imageUrl'],
                                  name: map['name'],
                                  price:
                                      double.tryParse(
                                        map['price'].toString().replaceAll(
                                          RegExp(r'[^0-9\.]'),
                                          '',
                                        ),
                                      ) ??
                                      0,
                                  rating: map['rating'] ?? 0,
                                  desc: map['desc'] ?? '',
                                ),
                              );
                              context.push('/product-details', extra: product);
                            },
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/cart');
        },
        label: const Text(
          'Show Cart',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final count = state.items.length;
            return InkWell(
              onTap: () {
                context.push('/cart');
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 5,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        onApplyFilter: (sortBy, category) {
          setState(() {
            currentSort = sortBy;
            currentCategory = category;
          });
        },
      ),
    );
  }
}

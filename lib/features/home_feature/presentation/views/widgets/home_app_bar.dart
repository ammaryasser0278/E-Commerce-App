import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/features/order_feature/logic/cart_cubit.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';

/// Custom app bar for the home screen with view toggle and filter options
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isGridView;
  final VoidCallback onToggleView;
  final VoidCallback onShowFilter;

  const HomeAppBar({
    super.key,
    required this.isGridView,
    required this.onToggleView,
    required this.onShowFilter,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [const AppBarTitle(title: 'SuppMart')],
      ),
      leading: Icon(Icons.fitness_center, size: 28, color: Colors.green),
      actions: [
        IconButton(
          onPressed: onToggleView,
          icon: Icon(
            isGridView ? Icons.list : Icons.grid_view,
            color: Colors.green[600],
          ),
        ),
        IconButton(
          onPressed: onShowFilter,
          icon: Icon(Icons.filter_list, color: Colors.green[600]),
        ),
        BlocBuilder<CartCubit, CartState>(
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
                    onPressed: () => context.push('/cart'),
                    icon: Icon(Icons.shopping_cart, color: Colors.green[500]),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 5,
                      top: 2,
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
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.green[600]),
          onSelected: (value) => _handleMenuSelection(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'orders',
              child: Row(
                children: [
                  Icon(Icons.shopping_bag, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Order History'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'payment',
              child: Row(
                children: [
                  Icon(Icons.payment, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Payment'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'seller',
              child: Row(
                children: [
                  Icon(Icons.dashboard, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Seller Dashboard'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'orders':
        context.push('/orders');
        break;
      case 'payment':
        context.push('/payment', extra: 99.99);
        break;
      case 'seller':
        context.push('/seller-dashboard');
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

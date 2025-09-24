import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/stats_card.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/order_card.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/quick_action_card.dart';

/// Overview tab for seller dashboard with stats and recent orders
class OverviewTab extends StatelessWidget {
  final TabController tabController;

  const OverviewTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          const Text(
            'Today\'s Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              StatsCard(
                title: 'Total Sales',
                value: '\$2,450',
                icon: Icons.attach_money,
                color: Colors.green[600],
                onTap: () => tabController.animateTo(1),
              ),
              StatsCard(
                title: 'Orders',
                value: '24',
                icon: Icons.shopping_bag,
                color: Colors.blue[600],
                onTap: () => tabController.animateTo(1),
              ),
              StatsCard(
                title: 'Products',
                value: '156',
                icon: Icons.inventory,
                color: Colors.orange[600],
                onTap: () => tabController.animateTo(2),
              ),
              StatsCard(
                title: 'Pending',
                value: '8',
                icon: Icons.pending_actions,
                color: Colors.red[600],
                onTap: () => tabController.animateTo(1),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Orders
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ..._getRecentOrders().map((order) => OrderCard(order: order)),

          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: QuickActionCard(
                  title: 'Add Product',
                  icon: Icons.add_box,
                  color: Colors.green,
                  onTap: () {
                    // Navigate to add product
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickActionCard(
                  title: 'View Analytics',
                  icon: Icons.analytics,
                  color: Colors.blue,
                  onTap: () {
                    // Navigate to analytics
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getRecentOrders() {
    return [
      {
        'id': '#ORD-001',
        'customer': 'John Doe',
        'status': 'pending',
        'items': 3,
        'total': '89.97',
      },
      {
        'id': '#ORD-002',
        'customer': 'Jane Smith',
        'status': 'processing',
        'items': 2,
        'total': '45.98',
      },
      {
        'id': '#ORD-003',
        'customer': 'Mike Johnson',
        'status': 'shipped',
        'items': 1,
        'total': '29.99',
      },
    ];
  }
}

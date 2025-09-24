import 'package:flutter/material.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/order_card.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/stat_card.dart';

/// Orders tab for seller dashboard with order management
class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Stats
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Pending',
                  value: '8',
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Processing',
                  value: '12',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Shipped',
                  value: '4',
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Orders List
          const Text(
            'All Orders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ..._getAllOrders().map((order) => OrderCard(order: order)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAllOrders() {
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
      {
        'id': '#ORD-004',
        'customer': 'Sarah Wilson',
        'status': 'delivered',
        'items': 4,
        'total': '120.50',
      },
      {
        'id': '#ORD-005',
        'customer': 'David Brown',
        'status': 'pending',
        'items': 2,
        'total': '67.99',
      },
    ];
  }
}

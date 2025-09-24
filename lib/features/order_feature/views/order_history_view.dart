import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';
import 'package:supplements_app/core/common_widgets/leading_button.dart';
import 'package:supplements_app/features/order_feature/views/widgets/order_card.dart';
import 'package:supplements_app/features/order_feature/views/widgets/order_filter_chips.dart';
import 'package:supplements_app/features/order_feature/views/widgets/order_details_bottom_sheet.dart';
import 'package:supplements_app/features/order_feature/views/widgets/order_tracking_view.dart';

/// Main screen for displaying order history with filtering and tracking
class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  String selectedFilter = 'all';

  // Sample order data - in a real app, this would come from a service
  final List<Map<String, dynamic>> orders = [
    {
      'id': '#ORD-001',
      'date': '2024-01-15',
      'status': 'delivered',
      'total': 89.97,
      'items': [
        {'name': 'Whey Protein Powder', 'quantity': 2, 'price': 29.99},
        {'name': 'Multivitamin Complex', 'quantity': 1, 'price': 19.99},
        {'name': 'Omega-3 Fish Oil', 'quantity': 1, 'price': 24.99},
      ],
      'trackingNumber': 'TRK123456789',
    },
    {
      'id': '#ORD-002',
      'date': '2024-01-10',
      'status': 'shipped',
      'total': 45.98,
      'items': [
        {'name': 'Vitamin D3', 'quantity': 2, 'price': 14.99},
        {'name': 'Creatine Monohydrate', 'quantity': 1, 'price': 22.99},
      ],
      'trackingNumber': 'TRK987654321',
    },
    {
      'id': '#ORD-003',
      'date': '2024-01-08',
      'status': 'processing',
      'total': 67.97,
      'items': [
        {'name': 'BCAA Powder', 'quantity': 1, 'price': 27.99},
        {'name': 'Pre-Workout', 'quantity': 1, 'price': 39.98},
      ],
      'trackingNumber': null,
    },
    {
      'id': '#ORD-004',
      'date': '2024-01-05',
      'status': 'cancelled',
      'total': 34.98,
      'items': [
        {'name': 'Protein Bars', 'quantity': 2, 'price': 17.49},
      ],
      'trackingNumber': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppBarTitle(title: 'Order History'),
        centerTitle: true,
        leading: LeadingButton(),
        actions: [
          IconButton(
            onPressed: _showFilterBottomSheet,
            icon: Icon(Icons.filter_list, color: Colors.green[600]),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          OrderFilterChips(
            selectedFilter: selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _getFilteredOrders().length,
              itemBuilder: (context, index) {
                final order = _getFilteredOrders()[index];
                return OrderCard(
                  order: order,
                  onTap: () => _showOrderDetails(order),
                  onReorder: order['status'] == 'delivered'
                      ? () => _reorderItems(order)
                      : null,
                  onTrack: order['trackingNumber'] != null
                      ? () => _trackOrder(order)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Event handlers
  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailsBottomSheet(
        order: order,
        onReorder: order['status'] == 'delivered'
            ? () {
                Navigator.pop(context);
                _reorderItems(order);
              }
            : null,
        onTrack: order['trackingNumber'] != null
            ? () {
                Navigator.pop(context);
                _trackOrder(order);
              }
            : null,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...['all', 'delivered', 'shipped', 'processing', 'cancelled'].map(
              (filter) => RadioListTile<String>(
                title: Text(_getFilterLabel(filter)),
                value: filter,
                groupValue: selectedFilter,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
                activeColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _reorderItems(Map<String, dynamic> order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${order['items'].length} items added to cart'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _trackOrder(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderTrackingView(order: order)),
    );
  }

  // Helper methods
  List<Map<String, dynamic>> _getFilteredOrders() {
    if (selectedFilter == 'all') return orders;
    return orders.where((order) => order['status'] == selectedFilter).toList();
  }

  String _getFilterLabel(String filter) {
    switch (filter) {
      case 'all':
        return 'All Orders';
      case 'delivered':
        return 'Delivered';
      case 'shipped':
        return 'Shipped';
      case 'processing':
        return 'Processing';
      case 'cancelled':
        return 'Cancelled';
      default:
        return filter;
    }
  }
}

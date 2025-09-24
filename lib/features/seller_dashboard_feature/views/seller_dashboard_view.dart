import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/app_bar_title.dart';
import 'package:supplements_app/core/common_widgets/leading_button.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/overview_tab.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/orders_tab.dart';
import 'package:supplements_app/features/seller_dashboard_feature/views/widgets/products_tab.dart';

/// Main seller dashboard with tabbed interface for managing orders and products
class SellerDashboardView extends StatefulWidget {
  const SellerDashboardView({super.key});

  @override
  State<SellerDashboardView> createState() => _SellerDashboardViewState();
}

class _SellerDashboardViewState extends State<SellerDashboardView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const AppBarTitle(title: 'Seller Dashboard'),
        centerTitle: true,
        leading: LeadingButton(),
        actions: [
          IconButton(
            onPressed: () {
              // Add notification action
            },
            icon: Icon(Icons.notifications_outlined, color: Colors.green[600]),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green[700],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.green[700],
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Orders'),
            Tab(text: 'Products'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTab(tabController: _tabController),
          const OrdersTab(),
          const ProductsTab(),
        ],
      ),
    );
  }
}

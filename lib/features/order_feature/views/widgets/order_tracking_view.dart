import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/status_chip.dart';

/// Screen for tracking order progress with timeline
class OrderTrackingView extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderTrackingView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Track Order',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ${order['id']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tracking Number: ${order['trackingNumber']}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    StatusChip(status: order['status']),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tracking Timeline
            const Text(
              'Order Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _buildTrackingTimeline(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final trackingSteps = [
      {
        'status': 'order_placed',
        'title': 'Order Placed',
        'date': '2024-01-05',
        'completed': true,
      },
      {
        'status': 'processing',
        'title': 'Processing',
        'date': '2024-01-06',
        'completed': true,
      },
      {
        'status': 'shipped',
        'title': 'Shipped',
        'date': '2024-01-08',
        'completed':
            order['status'] == 'shipped' || order['status'] == 'delivered',
      },
      {
        'status': 'delivered',
        'title': 'Delivered',
        'date': '2024-01-10',
        'completed': order['status'] == 'delivered',
      },
    ];

    return Column(
      children: trackingSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isLast = index == trackingSteps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: (step['completed'] as bool)
                        ? Colors.green
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: (step['completed'] as bool)
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: (step['completed'] as bool)
                        ? Colors.green
                        : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 16),

            // Step content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: (step['completed'] as bool)
                            ? Colors.green[700]
                            : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['date'] as String,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

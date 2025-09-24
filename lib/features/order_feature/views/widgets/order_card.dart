import 'package:flutter/material.dart';
import 'package:supplements_app/core/common_widgets/status_chip.dart';

/// Widget for displaying individual order information
class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onTap;
  final VoidCallback? onReorder;
  final VoidCallback? onTrack;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
    this.onReorder,
    this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StatusChip(status: order['status']),
                ],
              ),
              const SizedBox(height: 8),

              // Order Date
              Text(
                'Ordered on ${_formatDate(order['date'])}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),

              // Order Items Preview
              ...order['items']
                  .take(2)
                  .map<Widget>(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${item['quantity']}x ${item['name']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            '\$${(item['quantity'] * item['price']).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              if (order['items'].length > 2)
                Text(
                  '+${order['items'].length - 2} more items',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),

              const SizedBox(height: 12),
              const Divider(),

              // Order Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${order['total'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  Row(
                    children: [
                      if (onReorder != null)
                        TextButton.icon(
                          onPressed: onReorder,
                          icon: const Icon(Icons.shopping_cart, size: 16),
                          label: const Text('Reorder'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green[600],
                          ),
                        ),
                      if (onTrack != null) ...[
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: onTrack,
                          icon: const Icon(Icons.local_shipping, size: 16),
                          label: const Text('Track'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    final dateTime = DateTime.parse(date);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

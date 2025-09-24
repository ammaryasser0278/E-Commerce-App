import 'package:flutter/material.dart';

/// Widget for selecting payment method
class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),

        _buildPaymentMethodOption(
          'card',
          'Credit/Debit Card',
          Icons.credit_card,
        ),
        const SizedBox(height: 12),
        _buildPaymentMethodOption('cash', 'Cash on Delivery', Icons.money),
      ],
    );
  }

  Widget _buildPaymentMethodOption(String value, String title, IconData icon) {
    final isSelected = selectedMethod == value;
    return InkWell(
      onTap: () => onMethodSelected(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green[600] : Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.green[700] : Colors.black,
              ),
            ),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: Colors.green[600]),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Widget for displaying payment progress with steps
class PaymentProgressIndicator extends StatelessWidget {
  final int currentStep;

  const PaymentProgressIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildProgressStep(0, 'Payment', currentStep >= 0),
          Expanded(child: _buildProgressLine(currentStep >= 1)),
          _buildProgressStep(1, 'Review', currentStep >= 1),
          Expanded(child: _buildProgressLine(currentStep >= 2)),
          _buildProgressStep(2, 'Complete', currentStep >= 2),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String title, bool isActive) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isActive
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.green[700] : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Container(
      height: 2,
      color: isActive ? Colors.green : Colors.grey[300],
      margin: const EdgeInsets.only(top: 15),
    );
  }
}

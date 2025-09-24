import 'package:flutter/material.dart';

class AppSnackBars {
  static SnackBar success(String message) {
    return _buildSnackBar(
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static SnackBar error(String message) {
    return _buildSnackBar(
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static SnackBar info(String message) {
    return _buildSnackBar(
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  static SnackBar warning(String message) {
    return _buildSnackBar(
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }

  // 🔹 Private builder (مش بيتنادي بره الكلاس)
  static SnackBar _buildSnackBar({
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }
}

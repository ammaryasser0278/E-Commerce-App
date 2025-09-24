import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'SuppMart',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.green[700],
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  static const String _cartKey = 'cart_items_v1';

  Future<List<Map<String, dynamic>>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveCart(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(items);
    await prefs.setString(_cartKey, jsonString);
  }
}

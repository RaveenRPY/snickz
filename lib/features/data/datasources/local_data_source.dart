import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/item_entity.dart';

class LocalDataSource {
  Future<void> setCartItems(List<ItemEntity> items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonStringList =
        items.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList('cartItems', jsonStringList);
  }

  Future<List<ItemEntity>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? jsonStringList = prefs.getStringList('cartItems');

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => ItemEntity.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> clearCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
  }
}

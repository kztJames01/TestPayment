import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
   Map<String, CartItem> _items= {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount{
    return _items.length == null ? 0 : _items.length;
  }

  void addItem(String productId, String title, double price, int quantity) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingValue) => CartItem(
              id: existingValue.id,
              title: existingValue.title,
              price: existingValue.price,
              quantity: existingValue.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: productId, title: title, price: price, quantity: quantity));
    }
    notifyListeners();
  }
}

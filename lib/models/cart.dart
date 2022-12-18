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
  final Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity.toDouble();
    });
    return total;
  }

  int get itemCount {
    return _items.length == null ? 0 : _items.length;
  }

  void addItem(String productId, String title, double price, int quantity) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingValue) => CartItem(
              id: DateTime.now().toString(),
              title: existingValue.title,
              price: existingValue.price,
              quantity: existingValue.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearWhenOrder() {
    _items.clear();
    notifyListeners();
  }
}

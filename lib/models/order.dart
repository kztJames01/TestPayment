import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/cart.dart';

class OrderItem {
  final String id;
  final double total;
  final DateTime dateTime;
  final List<CartItem> products;
  OrderItem(
      {required this.id,
      required this.total,
      required this.dateTime,
      required this.products});
}

class Order with ChangeNotifier{
  List<OrderItem> order = [];

  List<OrderItem> get orders {
    return [...order];
  }

  void addOrder(List<CartItem> products, double total) {
    order.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            total: total,
            dateTime: DateTime.now(),
            products: products));
  }
}

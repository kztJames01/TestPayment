import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final double price;
  final int quantity;
  CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Chip(
            label: Text(
              "\$$price",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          title: Text(title),
          subtitle: Text("Total: \$${price * quantity}"),
          trailing: Text(
            "$quantity x",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

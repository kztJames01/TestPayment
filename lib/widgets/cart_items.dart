
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final double price;
  final int quantity;
  const CartItem(
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
      confirmDismiss: (direction) async{
        return await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Alert"),
                  content: const Text("Are you sure you want to delete?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text("Yes"))
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
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

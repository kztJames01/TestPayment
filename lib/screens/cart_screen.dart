import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/cart_items.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  TextButton(onPressed: () {}, child: Text("Order Now")),
                ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount:cart.items.length,
            itemBuilder: ((context, index) {
            return CartItem(
                //using values.toList()
                id: cart.items.values.toList()[index].id,
                title: cart.items.values.toList()[index].title,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity);
          })),
        )
      ]),
    );
  }
}

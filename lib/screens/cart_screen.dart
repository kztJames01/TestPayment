import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/order.dart';
import 'package:flutter_application_1/screens/edit_screen.dart';
import 'package:flutter_application_1/screens/order_screen.dart';
import 'package:flutter_application_1/widgets/cart_items.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static String routeName = "/cart_screen";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ), 
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, OrderScreen.orderRouteName);
              },
              child: Text("Order Screen")),
              TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Edit.routeName);
              },
              child: Text("Edit Screen"))
        ],
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
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
                  TextButton(
                      onPressed: () {
                        order.addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearWhenOrder();
                      },
                      child: Text("Order Now")),
                ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: ((context, index) {
                return CartItem(
                    //using values.toList()
                    id: cart.items.values.toList()[index].id,
                    productId: cart.items.keys.toList()[index],
                    title: cart.items.values.toList()[index].title,
                    price: cart.items.values.toList()[index].price,
                    quantity: cart.items.values.toList()[index].quantity);
              })),
        )
      ]),
    );
  }
}

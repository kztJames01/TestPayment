import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Chip(label:Text("\$$price",style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,),
        title: Text(title),
        subtitle: Text("Total: \$${price*quantity}"),
        trailing: Text("$quantity x",style: TextStyle(color: Colors.black),),
      ),
    );
  }
}

import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/order.dart' as ord;
import '../models/order.dart';

class OrderScreen extends StatelessWidget {
  static const orderRouteName = '/order';
  OrderScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FluentIcons.arrow_circle_left_24_regular),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) => OrderItem(order: orderData.order[index],index: index,)),
    );
  }
}

class OrderItem extends StatefulWidget {
  OrderItem({super.key,required this.order,required this.index});
  final int index;
  final ord.OrderItem order;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
   bool _expanded = false;
  @override
  Widget build(BuildContext context) {
     final orderData = Provider.of<Order>(context);
    return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      title: Text(
                        "\$${orderData.orders[widget.index].total}",
                      ),
                      trailing: IconButton(
                        icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expanded = !_expanded;
                          });
                        },
                      ),
                      subtitle: Text(DateFormat.yMMMEd()
                          .format(orderData.orders[widget.index].dateTime)),
                    ),
                    if (_expanded)
                      Container(
                        height:
                            min(widget.order.products.length * 20.0 + 100, 180),
                        child: ListView(
                            children: widget.order.products
                                .map((product) => Row(
                                      children: <Widget>[
                                        Text(product.title,style: TextStyle(color: Colors.black),),
                                        Spacer(),
                                        Text('${product.quantity}x \$${product.price}',style: TextStyle(color: Colors.blueGrey),)
                                      ],
                                    ))
                                .toList()),
                      )
                  ],
                ),
              );
  }
}
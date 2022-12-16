import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';

class OrderScreen extends StatelessWidget {
  static const orderRouteName = '/order';
  const OrderScreen({super.key});

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
          itemBuilder: (context, index) => Card(
              margin: EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  title: Text(
                    "\$${orderData.orders[index].total}",
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.expand_circle_down),
                    onPressed: () {},
                  ),
                  subtitle: 
                      Text(DateFormat.yMMMEd().format(orderData.orders[index].dateTime)),
                ),
              )),
    );
  }
}

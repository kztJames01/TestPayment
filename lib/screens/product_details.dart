import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:provider/provider.dart';

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});
  static const RouteName = '/product_details.dart';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<ProductProvider>(context).findbyId(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            FluentIcons.arrow_circle_left_24_regular,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            loadedProduct.title,
            style: Theme.of(context).textTheme.headline1,
          )
        ]),
      ),
    );
  }
}

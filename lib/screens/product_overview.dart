import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/product_details.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';

class ProductOverView extends StatelessWidget {
  ProductOverView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).appBarTheme.iconTheme!.color,
                size: Theme.of(context).appBarTheme.iconTheme!.size,
              )),
        ),
        body: productGrid());
  }
}

class productGrid extends StatelessWidget {
  const productGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context).item;
    return GridView.builder(
        itemCount: productData.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              footer: GridTileBar(
                subtitle: Text(
                  productData[index].price.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                backgroundColor: Colors.black45,
                title: Text(
                  productData[index].title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                trailing: IconButton(
                    onPressed: () {
                      productData[index].isFavorite == true;
                    },
                    icon: Icon(Icons.arrow_right,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).iconTheme.size)),
                leading: IconButton(
                    onPressed: () {
                      productData[index].isFavorite == true;
                    },
                    icon: Icon(Icons.favorite,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).iconTheme.size)),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(PackageDetails.RouteName,
                      arguments: productData[index].id);
                },
                child: Image.network(
                  productData[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }
}

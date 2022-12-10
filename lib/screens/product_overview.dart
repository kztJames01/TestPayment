import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/product_details.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';

class ProductOverView extends StatelessWidget {
  ProductOverView({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context).item;
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
        body: GridView.builder(
            itemCount: productData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2),
            itemBuilder: (context, index) => ChangeNotifierProvider(
                create: (context) => productData[index],
                child: const productGrid())));
  }
}

class productGrid extends StatelessWidget {
  const productGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          subtitle: Text(
            product.price.toString(),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          backgroundColor: Colors.black45,
          title: Text(
            product.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_right,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size)),
          leading: IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size)),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PackageDetails.RouteName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

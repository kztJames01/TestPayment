import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/product_details.dart';
import 'package:flutter_application_1/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';

enum FilterOptions { Favorites, All }

bool selectedValue = false;

class ProductOverView extends StatefulWidget {
  const ProductOverView({super.key});

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final cart = Provider.of<Cart>(context);
    final products =
        selectedValue == true ? productData.FavouriteItems : productData.item;
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
          actions: [
            PopupMenuButton(
                icon: Icon(FluentIcons.filter_28_regular),
                onSelected: (FilterOptions value) {
                  setState(() {
                    if (value == FilterOptions.Favorites) {
                      selectedValue = true;
                    } else {
                      selectedValue = false;
                    }
                  });
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text("Show All"),
                        value: FilterOptions.All,
                      ),
                      const PopupMenuItem(
                        child: Text("Favorites"),
                        value: FilterOptions.Favorites,
                      )
                    ]),
            Consumer<Cart>(
              builder: (_, value, child1) => Badge(
                  color: Colors.black,
                  value: value.itemCount.toString(),
                  child: child1!),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: (() {
                  Navigator.pushNamed(context, CartScreen.routeName);
                }),
              ),
            )
          ],
        ),
        body: Container(
            width: size.width,
            height: size.height * 0.9,
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: products[index], child: productGrid()),
            )));
  }
}

class productGrid extends StatelessWidget {
  const productGrid({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
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
              onPressed: () {
                cart.addItem(
                    product.id.toString(), product.title, product.price, 1);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: "Undo",
                      textColor: Colors.amber[300],
                      onPressed: () {
                        cart.removeSingleItem(product.id.toString());
                      },
                    ),
                    margin: const EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Added Item",
                      style: Theme.of(context).textTheme.bodyText2,
                    )));
              },
              icon: Icon(FluentIcons.shopping_bag_24_regular,
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
            Navigator.pushNamed(context, PackageDetails.RouteName,
                arguments: product.id);
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

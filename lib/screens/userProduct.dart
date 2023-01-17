import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:flutter_application_1/screens/add_product.dart';
import 'package:provider/provider.dart';

import 'edit_screen.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/userproduct';
  const UserProduct({super.key});
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<ProductProvider>(context,listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final _userProduct = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.addRoute);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: _userProduct.item.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.network(
                        _userProduct.item[index].imageUrl,
                        errorBuilder: (context, error, stackTrace) => Container(
                            width: 100,
                            height: 100,
                            child:
                                Image.network(_userProduct.item[index].imageUrl)),
                      ),
                    ),
                  ),
                  title: Text(_userProduct.item[index].title),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Edit(oldProd: _userProduct.item[index])));
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}

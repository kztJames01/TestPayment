import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider.dart';
import 'package:provider/provider.dart';

import 'edit_screen.dart';

class UserProduct extends StatefulWidget {
  static const routeName = '/userproduct';
  const UserProduct({super.key});

  @override
  State<UserProduct> createState() => _UserProductState();
}

class _UserProductState extends State<UserProduct> {
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
      )),
      body: Container(
        child: ListView.builder(
            itemCount: _userProduct.item.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    _userProduct.item[index].imageUrl,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.network(_userProduct.item[index].imageUrl),
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
    );
  }
}

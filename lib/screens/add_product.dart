import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../providers/provider.dart';

class AddProduct extends StatefulWidget {
  static const addRoute = '/AddProduct';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _form = GlobalKey<FormState>();
  var isInit = true;

  TextEditingController controller3 = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode desNode = FocusNode();
  FocusNode imageNode = FocusNode();
  FocusNode titleNode = FocusNode();
  FocusNode cateNode = FocusNode();
  Product newProduct = Product(
      id: null,
      title: '',
      imageUrl: '',
      category: '',
      description: '',
      price: 0,
      isFavorite: false);

  @override
  void initState() {
    imageNode.addListener(updateImageFocus);
    super.initState();
  }

  void updateImageFocus() {
    if (!imageNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageNode.removeListener(updateImageFocus);
    titleNode.dispose();
    imageNode.dispose();
    priceNode.dispose();
    desNode.dispose();
    cateNode.dispose();
    controller3.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      await Provider.of<ProductProvider>(context, listen: false)
          .addProduct(newProduct);
    } catch (error) {
      return showCupertinoDialog(
          context: context,
          builder: (ctx) => AlertDialog(actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Exit"))
              ], title: Text("Error"), content: Text(error.toString())));
    } finally {
      Navigator.pop(context);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
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
                  _saveForm();
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _form,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  focusNode: titleNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input title';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newProduct = Product(
                      id: newProduct.id,
                      title: newValue.toString(),
                      imageUrl: newProduct.imageUrl,
                      category: newProduct.category,
                      description: newProduct.description,
                      price: newProduct.price,
                      isFavorite: newProduct.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(priceNode);
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  focusNode: priceNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input price';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newProduct = Product(
                      id: newProduct.id,
                      title: newProduct.title,
                      imageUrl: newProduct.imageUrl,
                      category: newProduct.category,
                      description: newProduct.description,
                      price: double.parse(newValue.toString()),
                      isFavorite: newProduct.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(cateNode);
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  focusNode: cateNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input category';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newProduct = Product(
                      id: newProduct.id,
                      title: newProduct.title,
                      imageUrl: newProduct.imageUrl,
                      category: newValue,
                      description: newProduct.description,
                      price: newProduct.price,
                      isFavorite: newProduct.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(desNode);
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  focusNode: desNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input description';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newProduct = Product(
                      id: newProduct.id,
                      title: newProduct.title,
                      imageUrl: newProduct.imageUrl,
                      category: newProduct.category,
                      description: newValue,
                      price: newProduct.price,
                      isFavorite: newProduct.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(imageNode);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: controller3.text.isEmpty
                        ? Text("Enter a Url")
                        : FittedBox(
                            child: Image.network(
                              controller3.text,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                    'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132__340.png');
                              },
                            ),
                            fit: BoxFit.fill,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller3,
                      decoration: InputDecoration(labelText: 'Image'),
                      focusNode: imageNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image url';
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'Please enter a correct URL address';
                        }

                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onSaved: (newValue) => newProduct = Product(
                          id: newProduct.id,
                          title: newProduct.title,
                          imageUrl: newValue.toString(),
                          category: newProduct.category,
                          description: newProduct.description,
                          price: newProduct.price,
                          isFavorite: newProduct.isFavorite),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

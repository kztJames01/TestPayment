import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';

class Edit extends StatefulWidget {
  final Product oldProd;
  Edit({super.key, required this.oldProd});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _form = GlobalKey<FormState>();
  var isInit = true;

  TextEditingController controller3 = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode desNode = FocusNode();
  FocusNode imageNode = FocusNode();
  FocusNode titleNode = FocusNode();
  var initialValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  Product _editedProduct = Product(
      id: null,
      title: '',
      imageUrl: '',
      category: '',
      description: '',
      price: 0,
      isFavorite: false);
  @override
  void dispose() {
    imageNode.removeListener(updateImageFocus);
    titleNode.dispose();
    imageNode.dispose();
    priceNode.dispose();
    desNode.dispose();

    controller3.dispose();
    super.dispose();
  }

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
  void didChangeDependencies() {
    if (isInit) {
      if (widget.oldProd.id != null) {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findbyId(widget.oldProd.id.toString());
        initialValues = {
          'title': widget.oldProd.title,
          'price': widget.oldProd.price.toString(),
          'description': widget.oldProd.description.toString()
        };
        controller3.text = widget.oldProd.imageUrl;
      }
    }
    isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (widget.oldProd.id != null) {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(widget.oldProd.id.toString(), _editedProduct);
      } catch (error) {
        print(error);
      }
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showCupertinoDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error Occured"),
                  content: Text(error.toString()),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        icon: Icon(Icons.exit_to_app))
                  ],
                ));
      });
    }
    Navigator.pop(context);
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
                  initialValue: initialValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  focusNode: titleNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input title';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: newValue.toString(),
                      imageUrl: _editedProduct.imageUrl,
                      category: widget.oldProd.category,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      isFavorite: widget.oldProd.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(priceNode);
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: initialValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  focusNode: priceNode,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Input price';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      imageUrl: _editedProduct.imageUrl,
                      category: widget.oldProd.category,
                      description: _editedProduct.description,
                      price: double.parse(newValue.toString()),
                      isFavorite: widget.oldProd.isFavorite),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(desNode);
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: initialValues['description'],
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
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      imageUrl: _editedProduct.imageUrl,
                      category: widget.oldProd.category,
                      description: newValue,
                      price: _editedProduct.price,
                      isFavorite: widget.oldProd.isFavorite),
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
                      onSaved: (newValue) => _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          imageUrl: newValue.toString(),
                          category: widget.oldProd.category,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          isFavorite: widget.oldProd.isFavorite),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

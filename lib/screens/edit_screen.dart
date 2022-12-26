import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  static const routeName = '/edit';
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  FocusNode priceNode = FocusNode();
  FocusNode desNode = FocusNode();
  FocusNode imageNode = FocusNode();
  FocusNode titleNode = FocusNode();
  @override
  void dispose() {
    titleNode.dispose();
    imageNode.dispose();
    priceNode.dispose();
    desNode.dispose();
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
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
        )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                focusNode: titleNode,
                controller: controller,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Input title';
                  }
                  return null;
                },
                onSaved: (newValue) => controller.text,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(priceNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                focusNode: priceNode,
                controller: controller1,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Input price';
                  }
                  return null;
                },
                onSaved: (newValue) => controller1.text,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(desNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                focusNode: desNode,
                controller: controller2,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Input description';
                  }
                  return null;
                },
                onSaved: (newValue) => controller2.text,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(imageNode);
                },
              ),
              Row(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    child: Image.network(''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image'),
                    focusNode: imageNode,
                    controller: controller3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Input Image';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      
                    },
                  )
                ],
              )
            ]),
          ),
        ));
  }
}

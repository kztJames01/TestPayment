import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/screens/product_overview.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String imageUrl;
  final String? category;
  final String? description;
  final double price;
  bool isFavorite = false;

  Product(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.category,
      required this.description,
      required this.price,
      required this.isFavorite});

  Future<void> toggleFavorite(String id) async{
    isFavorite != isFavorite;
    final url = Uri.https('fluttertest-50cc9-default-rtdb.firebaseio.com',
          '/products/$id.json');
    final response = await http.patch(url,body: json.encode({
      'title' : 
    }));
    notifyListeners();
  }
  
}

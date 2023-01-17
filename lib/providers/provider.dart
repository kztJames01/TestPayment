import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/products.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get item {
    return [..._items];
  }

  List<Product> get FavouriteItems {
    return _items
        .where(
          (element) => element.isFavorite,
        )
        .toList();
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.https(
        'fluttertest-50cc9-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          imageUrl: product.imageUrl,
          category: product.category,
          description: product.description,
          price: product.price,
          isFavorite: false);
      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchData() async {
    var url = Uri.https(
        'fluttertest-50cc9-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            id: prodId,
            title: prodData['title'],
            imageUrl: prodData['imageUrl'],
            category: prodData['category'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Product findbyId(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https(
          'fluttertest-50cc9-default-rtdb.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }
}

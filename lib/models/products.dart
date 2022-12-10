import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String description;
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

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

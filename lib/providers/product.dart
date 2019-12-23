import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
    @required this.description,
    @required this.price,
    this.isFavorite = false
  });

  Future<void> togglefavorite() async {
    final url = "https://flutter-shop-app-725c6.firebaseio.com/products/${this.id}.json";
    try{
      isFavorite = !isFavorite;
      notifyListeners();  
      final response = await http.patch(url,body: jsonEncode({
      "isFavorite" : isFavorite,  
      }));
      if(response.statusCode >= 400){
        throw Exception("Error encountered while adding favourite");
      }
    }catch(error){
      isFavorite = !isFavorite;
      notifyListeners();
      print(error.toString());
    }
  }
}
import 'package:flutter/material.dart';
import '../dummy_data.dart';
import './product.dart';

class ProductProvider with ChangeNotifier{
  List<Product> _products = dummyProduct;

  List<Product> get listofproducts{
    return [..._products];
  }

  List<Product> get getfavorite{
    return _products.where((pro){
      return pro.isFavorite;
    }).toList();
  } 

  Product findById(String id){
    return _products.firstWhere(
      (pro){
        return pro.id == id;
      }
    );
  }

  void addProduct(){
    notifyListeners();
  }

}
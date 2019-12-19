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

  void addProduct(Product pro){
    if(pro.id == null){
      final toadd = Product(
        id: DateTime.now().toString(),
        title: pro.title,
        description: pro.description,
        imageUrl: pro.imageUrl,
        price: pro.price
      );
      _products.add(toadd);
    }else{
      var index =  _products.indexOf(_products.firstWhere((val)=> val.id == pro.id));
      _products[index] = pro; 
    }
    notifyListeners();
  }

  void deleteProduct(String id){
    var index =  _products.indexOf(_products.firstWhere((val)=> val.id == id));
    _products.removeAt(index);
    notifyListeners();
  }

}
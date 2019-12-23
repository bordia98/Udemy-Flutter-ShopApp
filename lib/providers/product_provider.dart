import 'dart:convert';
import 'dart:core';                                                  
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dummy_data.dart';
import './product.dart';


class ProductProvider with ChangeNotifier{
  List<Product> _products = [];


  Future<void> getproductfromdatabase() async{
    final url = 'https://flutter-shop-app-725c6.firebaseio.com/products.json';
    try{
      final response = await http.get(url);
      print("Mujhe call kiya");
      List<Product> newlist =[];
      Map productlist = json.decode(response.body);
      productlist.forEach((key,dynamic value){
        var pro = Product(
          id: key,
          title: value["title"],
          price: value["price"],
          description: value["description"],
          imageUrl: value["imageUrl"],
          isFavorite: value["isFavorite"]
        );
        newlist.add(pro);
      });
      _products = [...newlist];
      notifyListeners();
    }catch(error){
      print(error.toString());
      throw error;
    }
  }

  List<Product> get listofproducts {
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

  Future<void> addProduct(Product pro) async{
    
    final url = 'https://flutter-shop-app-725c6.firebaseio.com/products.json';
    
    if(pro.id == null){
      try{
        final response = await http.post(url,
          body: jsonEncode({
            "title": pro.title,
            "description":pro.description,
            "imageUrl": pro.imageUrl,
            "price": pro.price,
            "isFavorite": pro.isFavorite
          })
        );
        print("*********************");
        print(json.decode(response.body));
        final toadd = Product(
          id: json.decode(response.body)['name'],
          title: pro.title,
          description: pro.description,
          imageUrl: pro.imageUrl,
          price: pro.price
        );
        _products.add(toadd);
        notifyListeners();
      }catch(error){
        print("yaha aaya hai error");
        print(error.toString());
        throw error;
      }
    }else{
      final updateurl = "https://flutter-shop-app-725c6.firebaseio.com/products/${pro.id}.json";
      try{
        final res = await http.patch(updateurl,
          body: jsonEncode({
              "title":pro.title,
              "description": pro.description,
              "price":pro.price,
              "imageUrl":pro.imageUrl
            })
          );

        if(res.statusCode >=400){
          throw Exception("Error encountered while updating");
        }
        var index =  _products.indexOf(_products.firstWhere((val)=> val.id == pro.id));
        _products[index] = pro; 
        notifyListeners();
      }catch(error){
        print(error.toString());
        throw error;
      }
    }
  }

  Future<void> deleteProduct(String id) async{
    final url = "https://flutter-shop-app-725c6.firebaseio.com/products/${id}.json";
    try{
      final response = await http.delete(url);

      if(response.statusCode >= 400){
        throw Exception("Error encountered while deleting");
      }
      var index =  _products.indexOf(_products.firstWhere((val)=> val.id == id));
      _products.removeAt(index);
      notifyListeners();
    }catch(error){
      print(error.toString());
      throw error;
    }
  }
}
import 'package:flutter/foundation.dart';

class CartItem{
  final String id;
  final String title;
  int quantity;
  final double price;
  final String url;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.url
  });
}

class Cart with ChangeNotifier{

  Map<String,CartItem> _items={};

  Map<String,CartItem> get item{
    return {..._items};
  }

  // List<CartItem> get listofitems{
  //   return _items.values.toList();
  // }

  int get itemcount{
    if( _items == null){
      return 0;
    }
    return _items.length;
  }

  double get totalamount{
    double total = 0;
    _items.forEach((key,it){
      total += (it.price * it.quantity);
    });
    // print(total);
    return total;
  }

  void additem(String productid, double price,String title, String url){
    if(_items !=null && _items.containsKey(productid)){
      _items.update(productid, (item){
        item.quantity = item.quantity + 1;
        return item;
      });
    }else{
      _items.putIfAbsent(productid, ()=> CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          url: url,
          quantity: 1
          )
        );
    }
    notifyListeners();
  }
  void removeitem(String id){
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
  
}

import 'package:flutter/foundation.dart';
import './cart.dart';


class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime time;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.product,
    @required this.time,
  });
}

class Order with ChangeNotifier{

  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
    return [..._orders];
  }

  int get totalorder{
    return orders.length;
  }

  void addOrder(List<CartItem> cartitem, double total){
    _orders.add(
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        product: cartitem,
        time: DateTime.now()
      )
    );
    notifyListeners();
  }
}

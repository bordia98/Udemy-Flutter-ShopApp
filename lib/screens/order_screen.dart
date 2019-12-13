import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';


class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
            itemBuilder: (ctx,index){
              return OrderItemTemplate(order: order.orders[index]);
            },
            itemCount: order.totalorder,
          ),
      );
  }
}
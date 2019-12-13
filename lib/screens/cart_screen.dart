import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';


class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      "Total Amount",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      "\$ ${cart.totalamount.toString()}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: RaisedButton(
                textColor: Theme.of(context).primaryColor,
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                      ),
                  ),
                ) ,
                onPressed: (){ 
                  Provider.of<Order>(context,listen: false).addOrder(
                    cart.item.values.toList(), 
                    cart.totalamount
                    );
                    cart.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil("/order", ModalRoute.withName("/"));
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemcount,
                itemBuilder: (ctx,index){
                  return ItemView(
                    productid: cart.item.keys.toList()[index],
                    id: cart.item.values.toList()[index].id,
                    title: cart.item.values.toList()[index].title,
                    url: cart.item.values.toList()[index].url,
                    price: cart.item.values.toList()[index].price,
                    quantity: cart.item.values.toList()[index].quantity,
                    );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
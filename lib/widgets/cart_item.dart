import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

 
class ItemView extends StatelessWidget {

  final String productid;
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String url;

  ItemView({
    this.productid,
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.url
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color:Theme.of(context).primaryColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction){
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Are You Sure"),
              content: Text("Do you want to Remove the Item ?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            )
          );
        },
        onDismissed: (direction){
          Provider.of<Cart>(context,listen: false).removeitem(productid);
        },
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                child: Image.network(url),
              ),
              title: Text(title),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: <Widget>[
                  Text("qty : $quantity x $price"),
                  Text(" = ${(quantity*price).toStringAsFixed(2)}")
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){
                    Provider.of<Cart>(context,listen: false).removeitem(productid);
                },
              ),
            ),
          ),
        ),
    );
  }
}
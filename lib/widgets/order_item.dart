import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart';


class OrderItemTemplate extends StatefulWidget {
  final OrderItem order;

  OrderItemTemplate({this.order});

  @override
  _OrderItemTemplateState createState() => _OrderItemTemplateState();
}

class _OrderItemTemplateState extends State<OrderItemTemplate> {
  bool _expand =false;
  @override
  
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Order Amount:  \$ ${widget.order.amount}",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20,  
                color: Theme.of(context).primaryColor
              ),
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(widget.order.time),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                // fontWeight: FontWeight.bold,
                // fontSize: 20,  
                color: Theme.of(context).accentColor
              ),
            ),
            trailing: IconButton(
              icon: _expand ? Icon(Icons.expand_less): Icon(Icons.expand_more),
              onPressed: (){
                setState(() {
                  _expand = !_expand;
                });
              },
            ),
          ),
          _expand ? Container(
            height: min(widget.order.product.length * 20.0 +100 ,180),
            child: ListView(
              children: widget.order.product.map( (pro)
                {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          pro.title,
                          style: TextStyle( 
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                          ),
                        ),
                        Text(
                          "\$ ${ (pro.quantity * pro.price).toStringAsFixed(2)}",
                          style: TextStyle( 
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).errorColor
                          ),    
                        )
                      ],
                    ),
                  );
                }
              ).toList(),
            )
          ): Container()
        ],
      )
    );
  }
}
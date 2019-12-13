import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../widgets/badge.dart';
import "../widgets/product_grid.dart";
import '../providers/cart.dart';

class ProductsOverviewScreen extends StatefulWidget {
  
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool fav=false;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text(
          "My Shop",
          textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (int value){
                setState(() {
                  if(value == 0){
                    fav = true;
                  }else{
                    fav = false;
                  }                  
                });
              },
              icon: Icon(
                Icons.more_vert
              ),
              itemBuilder: (_)=>[
                PopupMenuItem(
                  child: Text(
                    "Favorites Only",
                    ),
                    value: 0,
                ),
                PopupMenuItem(
                  child: Text(
                    "All",
                    ),
                    value: 1,
                ),
              ],
            ),
            Consumer<Cart>(
                builder: (_,cart, ch) => Badge(
                  child: ch,
                  value: cart.itemcount.toString(),
                ), 
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart
                      ),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/cart');
                    },
                ),
            )
          ],
      ),
      drawer: MainDrawer(),
      body: ProductGrid(fav),
    );
    return scaffold;
  }
}
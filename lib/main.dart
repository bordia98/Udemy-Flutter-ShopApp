import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/edit_product_screen.dart';
import './screens/user_product_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/product_provider.dart';
import './screens/order_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: ProductProvider(),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProvider.value(
            value: Order(),
          ),
        ],
        child: MaterialApp(
        title: 'Home',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(55, 25, 128, 1),
          accentColor: Colors.amber,
        ),
        // home: ProductsOverviewScreen(),
        routes: {
          "/": (ctx) => ProductsOverviewScreen(),
          "/product-detail-screen": (ctx) => ProductDetailScreen(),
          "/cart": (ctx) => CartScreen(),
          "/order": (ctx) => OrderScreen(),
          "/userproduct": (ctx) => UserProductScreen(),
          "/editproduct": (ctx) => EditProductScreen(),
        },
      ),
    );  
  }
}


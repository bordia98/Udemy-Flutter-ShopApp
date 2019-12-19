import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_drawer.dart';
import '../providers/product_provider.dart';
import '../widgets/user_product.dart';

class UserProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed("/editproduct",
              arguments: "");
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx,index){
            return Card(
              elevation: 10,
              child: UserProductItem(
                title: products.listofproducts[index].title,
                url: products.listofproducts[index].imageUrl,
                id: products.listofproducts[index].id,
                ),
            );
          },
          itemCount: products.listofproducts.length,
        ),
      ),
    );
  }
}
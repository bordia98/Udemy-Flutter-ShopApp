import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;

    final productData = Provider.of<ProductProvider>(context,listen: false);

    Product product = productData.findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        
        child: Container(
          // color: Colors.black45,
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.black54,
                height: 300,
                width: double.infinity,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Image.network(product.imageUrl),
              ),
              Container(
                child: const SizedBox(
                  height: 10,
                ),
              ),
              Container(
                width: double.infinity,
                // color: Colors.black54,
                color: Theme.of(context).accentColor,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(5),
                child: Text(
                  "Price:   \$ " + product.price.toString() + " /-",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 10,
                thickness: 5,
              ),
              Container(
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                  ),
              ),
              const Divider(
                height: 10,
                thickness: 5,
              ),
              Container(
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                    fontSize: 20
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
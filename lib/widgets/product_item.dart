import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {

  // final String url;
  // final String id;
  // final String title;

  // ProductItem({this.url,this.id,this.title});

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    var cart = Provider.of<Cart>(context,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
        child: Container(
          child: GestureDetector(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover ,
                ),
                onTap: (){
                  Navigator.of(context).pushNamed(
                    '/product-detail-screen',
                    arguments: product.id);
                },
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Colors.red,
            onPressed: (){
              product.togglefavorite();
            },
          ),
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: (){
              cart.additem(product.id, product.price, product.title,product.imageUrl);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
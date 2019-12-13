import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import './product_item.dart';


class ProductGrid extends StatelessWidget {

  final bool fav;

  ProductGrid(this.fav);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final toiterate = fav ? productData.getfavorite :  productData.listofproducts;

    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx,index) {
          return ChangeNotifierProvider.value(
            // don't try create method as it will not work here
            value: toiterate[index],
            child: ProductItem(),
          );  
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4/5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
          ),
        itemCount: toiterate.length,
      );
  }
}
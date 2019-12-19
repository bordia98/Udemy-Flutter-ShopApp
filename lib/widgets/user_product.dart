import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String url;
  final String title;
  final String id;

  UserProductItem({
    this.url,
    this.title,
    this.id
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(url)
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){ 
                Navigator.of(context).pushNamed("/editproduct",
                arguments: id);
              },
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                Provider.of<ProductProvider>(context).deleteProduct(id);
               },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
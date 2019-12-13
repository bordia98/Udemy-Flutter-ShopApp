import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Container(
              child: Text("Welcome to Your Shop")),
            automaticallyImplyLeading: false,
          ),
          Divider(
            thickness: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          Divider(
            thickness: 5,
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/order");
            },
          ),
          Divider(
            thickness: 5,
          ),
        ],
      ),
    );
  }
}
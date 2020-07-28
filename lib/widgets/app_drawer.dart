import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  static const routeName = 'app-drawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: AppBar(
              title: Text('Hello Friend!'),
              automaticallyImplyLeading: false,
            ),
          ),

          Card(

            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),

          Card(

            child: ListTile(
              leading: Icon(Icons.payment),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
            ),
          ),

          Card(

            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Your Cart'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

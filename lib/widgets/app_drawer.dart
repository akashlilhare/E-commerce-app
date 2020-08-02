import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product.dart';
class AppDrawer extends StatelessWidget {
  static const routeName = 'app-drawer';

  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 5,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(0)),
            child: Container(
              height: 150,
              child: AppBar(
                centerTitle: true,
                title: Text('Hello Friend!'),
                automaticallyImplyLeading: false,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Card(
            elevation: 10,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),

          Card(
            elevation: 10,
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Your Cart'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CartScreen.routeName);
              },
            ),
          ),

          Card(
            elevation: 10,
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
    elevation: 10,
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProduct.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

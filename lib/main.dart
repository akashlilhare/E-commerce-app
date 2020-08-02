import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/orders_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './widgets/app_drawer.dart';
import './screens/user_product.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],

      // builder: (ctx) => Products(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            cardColor: Colors.white70,
            cursorColor: Theme.of(context).primaryColor,
            dialogBackgroundColor: Colors.white70,
            hintColor: Colors.blueGrey,
            selectedRowColor: Colors.blueGrey,

          ),

          routes: {
            '/': (ctx) =>  ProductsOverviewScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            OrderScreen.routeName:(ctx) => OrderScreen(),
            AppDrawer.routeName:(ctx) => AppDrawer(),
            UserProduct.routeName:(ctx) => UserProduct(),
            EditProductScreen.routeName:(ctx) => EditProductScreen(),
          }),
    );
  }
}

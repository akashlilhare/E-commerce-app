import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/screens/auth_screen.dart';

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
import './providers/auth.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
              auth.token,
              previousProducts == null ? [] : previousProducts.items,
              auth.userID,
            ),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userID,
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],

        // builder: (ctx) => Products(),
        child: Consumer<Auth>(
          builder: (ctx, auth, child) => MaterialApp(
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
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      // ignore: non_constant_identifier_names
                      builder: (ctx, Snapshot) => Snapshot.connectionState == ConnectionState.waiting? SplashScreen() : AuthScreen()),
              routes: {
     //            '/': (ctx) =>  New(),
                CartScreen.routeName: (ctx) => CartScreen(),
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                AppDrawer.routeName: (ctx) => AppDrawer(),
                UserProduct.routeName: (ctx) => UserProduct(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}

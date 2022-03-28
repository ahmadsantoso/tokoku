import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoku/providers/auth.dart';
import 'package:tokoku/screens/auth_screen.dart';
import 'package:tokoku/screens/edit_product_screen.dart';
import 'package:tokoku/screens/user_products_screen.dart';

import './providers/cart.dart';
import './providers/products.dart';
import './providers/orders.dart';

import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // create: (ctx) => Auth(),
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          // create: (ctx) => Products(),
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          // create: (ctx) => Cart(),
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          // create: (ctx) => Orders(),
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Tokoku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProducstSreen.routeName: (ctx) => UserProducstSreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

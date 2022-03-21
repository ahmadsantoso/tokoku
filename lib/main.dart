import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tokoku/providers/cart.dart';
import 'package:tokoku/providers/product.dart';
import 'package:tokoku/screens/cart_screen.dart';

import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          // create: (ctx) => Products(),
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          // create: (ctx) => Cart(),
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Tokoku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}

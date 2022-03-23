import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tokoku/providers/products.dart';
import 'package:tokoku/screens/edit_product_screen.dart';
import 'package:tokoku/widgets/app_drawer.dart';
import 'package:tokoku/widgets/user_product_item.dart';

class UserProducstSreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(productsData.items[i].id,
                  productsData.items[i].imageUrl, productsData.items[i].title),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
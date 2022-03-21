import 'package:flutter/cupertino.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'b1',
        title: 'Intel i3 Gen 12th',
        description: 'Intel i3 Generasi ke-12',
        price: 1670000,
        imageUrl:
            'https://media.ldlc.com/r1600/ld/products/00/05/91/49/LD0005914913_1.jpg'),
    Product(
        id: 'b2',
        title: 'Intel i5 Gen 12th',
        description: 'Intel i5 Generasi ke-12',
        price: 2570000,
        imageUrl:
            'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2022/1/6/80a0506c-c49e-4250-af96-26bad893d1e6.png'),
    Product(
        id: 'b3',
        title: 'Intel i7 Gen 12th',
        description: 'Intel i7 Generasi ke-12',
        price: 6450000,
        imageUrl:
            'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/12/23/2210ca74-95cb-49a6-890c-cdc8110744e7.jpg'),
    Product(
        id: 'b4',
        title: 'Intel i9 Gen 12th',
        description: 'Intel i9 Generasi ke-12',
        price: 7810000,
        imageUrl:
            'https://cf.shopee.co.id/file/450c1939af30a0121f4ac70fefb67db5')
  ];

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findMyId(String Id) {
    return _items.firstWhere((prod) => prod.id == Id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    //_items.add (value);
    notifyListeners();
  }
}

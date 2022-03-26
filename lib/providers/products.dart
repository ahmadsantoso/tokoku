import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'b1',
    //     title: 'Intel i3 Gen 12th',
    //     description:
    //         'CPU Specifications \n Total Cores : 4 \n # of Performance-cores : 4 \n # of Efficient-cores : 0 \n Total Threads : 8 \n Max Turbo Frequency : 4.30 GHz \n Performance-core Max Turbo Frequency : 4.30 GHz \n Performance-core Base Frequency : 3.30 GHz \n Cache : 12 MB Intel® Smart Cache \n Total L2 Cache : 5 MB \n Processor Base Power : 58 W \n Maximum Turbo Power : 89 W \n Max Memory Size (dependent on memory type) : 128 GB \n Sockets Supported : FCLGA1700',
    //     price: 1670000,
    //     imageUrl:
    //         'https://images.tokopedia.net/img/cache/200-square/VqbcmM/2022/2/21/1eec2d02-e42a-4350-9add-5222e7e42035.jpg?ect=4g'),
    // Product(
    //     id: 'b2',
    //     title: 'Intel i5 Gen 12th',
    //     description:
    //         'CPU Specifications \n Total Cores : 6 \n # of Performance-cores : 6  \n # of Efficient-cores : 0 \n Total Threads : 12 \n Max Turbo Frequency : 4.40 GHz \n Performance-core Max Turbo Frequency : 4.40 GHz \n Performance-core Base Frequency : 2.50 GHz \n Cache : 18 MB Intel® Smart Cache \n Total L2 Cache : 7.5 MB \n Processor Base Power : 65 W \n Maximum Turbo Power : 117 W \n Max Memory Size (dependent on memory type) : 128 GB \n Sockets Supported : FCLGA1700',
    //     price: 2570000,
    //     imageUrl:
    //         'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2022/1/6/7e51a4ed-5a47-447f-a716-169ead40275a.png'),
    // Product(
    //     id: 'b3',
    //     title: 'Intel i7 Gen 12th',
    //     description:
    //         'CPU Specifications \n Total Cores : 12 \n # of Performance-cores : 8 \n # of Efficient-cores : 4 \n Total Threads : 20 \n Max Turbo Frequency : 4.90 GHz \n Intel® Turbo Boost Max Technology 3.0 Frequency : 4.90 GHz \n Performance-core Max Turbo Frequency : 4.80 GHz \n Efficient-core Max Turbo Frequency : 3.60 GHz \n Performance-core Base Frequency : 2.10 GHz \n Efficient-core Base Frequency : 1.60 GHz \n Cache : 25 MB Intel® Smart Cache \n Total L2 Cache : 12 MB \n Processor Base Power : 65 W \n Maximum Turbo Power : 180 W \n Max Memory Size (dependent on memory type) : 128 GB \n Sockets Supported : FCLGA1700',
    //     price: 6450000,
    //     imageUrl:
    //         'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/12/23/2210ca74-95cb-49a6-890c-cdc8110744e7.jpg'),
    // Product(
    //     id: 'b4',
    //     title: 'Intel i9 Gen 12th',
    //     description:
    //         'CPU Specifications \n Total Cores 16 \n # of Performance-cores8 \n # of Efficient-cores8 \n Total Threads 24 \n Max Turbo Frequency 5.20 GHz \n Intel® Turbo Boost Max Technology 3.0 Frequency ‡ 5.20 GHz \n Performance-core Max Turbo Frequency 5.10 GHz \n Efficient-core Max Turbo Frequency 3.90 GHz \n Performance-core Base Frequency3.20 GHz \n Efficient-core Base Frequency2.40 GHz \n Cache 30 MB Intel® Smart Cache \n Total L2 Cache14 MB \n Processor Base Power 125 W \n Maximum Turbo Power 241 W \n \n Supplemental Information \n Embedded Options Available No \n \n Memory Specifications \n Max Memory Size (dependent on memory type) 128 GB \n Memory Types Up to DDR5 4800 MT/s \n Up to DDR4 3200 MT/s \n Max # of Memory Channels 2 \n Max Memory Bandwidth 76.8 GB/s',
    //     price: 7810000,
    //     imageUrl:
    //         'https://images.tokopedia.net/img/cache/200-square/hDjmkQ/2022/2/27/36310807-061e-4a95-b8e0-a1dd35344d21.jpg.webp?ect=4g'),
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

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://tokoku-6bf28-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
      // print("id: " + loadedProducts[0].id);
      // print("id: " + _items[0].id);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        'tokoku-6bf28-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        id: json.decode(response.body)['name'],
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      //_items.insert(0, newProduct); at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}

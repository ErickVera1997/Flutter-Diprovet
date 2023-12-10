import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsNotifier extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-38eb4-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  String _selectedCategory = 'Vitaminas';
  bool isLoading = false;

  final List<Category> categories = [
    Category('Desparasitante', 'assets/home/desparasitante.jpeg'),
    Category('Vitaminas', 'assets/home/vitaminas.jpeg'),
    Category('Desinfectante', 'assets/home/desinfectante.jpeg'),
    Category('Antibiótico', 'assets/home/antibiotico.jpeg'),
    Category('Más', 'assets/logo.jpeg'),
  ];

  List<Product> filteredProducts = [];

  ProductsNotifier() {
    loadProducts();
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    filterProducts(selectedCategory);
    notifyListeners();
  }

  loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
  }

  filterProducts(String category) {
    filteredProducts =
        products.where((item) => item.category == category).toList();
    notifyListeners();
  }
}

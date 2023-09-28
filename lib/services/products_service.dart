import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-38eb4-default-rtdb.firebaseio.com';
  List<Product> products = [];
  String _selectedCategory = 'Vitaminas';
  bool isLoading = false;
  bool isSaving = true;

  List<Category> categories = [
    Category('Desparasitante', 'assets/home/desparasitante.jpeg'),
    Category('Vitaminas', 'assets/home/vitaminas.jpeg'),
    Category('Desinfectante', 'assets/home/desinfectante.jpeg'),
    Category('Antibiótico', 'assets/home/antibiotico.jpeg'),
    Category('Más', 'assets/logo.jpeg'),
  ];

  List<Product> filteredProducts = [];

  ProductsService() {
    loadProducts();
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    filtersProducts(valor);
    notifyListeners();
  }

  loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProdut = Product.fromMap(value);
      tempProdut.id = key;
      products.add(tempProdut);
    });
    isLoading = false;
    notifyListeners();
  }

  filtersProducts(String category) {
    filteredProducts.clear();
    for (var item in products) {
      if (item.category == category) {
        filteredProducts.add(item);
        notifyListeners();
      }
    }
  }
}

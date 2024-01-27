import 'package:flutter/cupertino.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';

import '../services/products_service.dart';

class ProductsNotifier extends ChangeNotifier {
  final ProductsService _productService;
  final List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = false;
  String _selectedCategory = 'Vitaminas';

  final List<Category> categories = [
    Category('Desparasitante', 'assets/home/desparasitante.jpeg'),
    Category('Vitaminas', 'assets/home/vitaminas.jpeg'),
    Category('Desinfectante', 'assets/home/desinfectante.jpeg'),
    Category('Antibiótico', 'assets/home/antibiotico.jpeg'),
    Category('Más', 'assets/logo.jpeg'),
  ];

  ProductsNotifier(this._productService) {
    loadProducts();
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    filterProducts(selectedCategory);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final productsMap = await _productService.fetchProducts();

      productsMap.forEach((key, value) {
        final tempProduct = Product.fromMap(value);
        tempProduct.id = key;
        products.add(tempProduct);
      });
    } catch (e) {
      // Handle error
      print('Error loading products: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void filterProducts(String category) {
    filteredProducts =
        products.where((item) => item.category == category).toList();
    notifyListeners();
  }
}

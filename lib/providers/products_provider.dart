import 'package:flutter/cupertino.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

class ProductsNotifier extends ChangeNotifier {
  ProductsNotifier({required this.productService}) {
    loadProducts();
  }
  final ProductsService productService;
  final List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = false;
  String _selectedCategory = 'Vitaminas';

  final List<Category> categories = [
    const Category('Desparasitante', 'assets/home/desparasitante.jpeg'),
    const Category('Vitaminas', 'assets/home/vitaminas.jpeg'),
    const Category('Desinfectante', 'assets/home/desinfectante.jpeg'),
    const Category('Antibiótico', 'assets/home/antibiotico.jpeg'),
    const Category('Más', 'assets/logo.jpeg'),
  ];

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    filterProducts(selectedCategory);
    notifyListeners();
  }

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final result = await productService.fetchProducts();
    result.fold(
      (errorMessage) {
        debugPrint('Error loading products: $errorMessage');
      },
      (productsMap) {
        for (final value in productsMap) {
          final tempProduct = Product.fromMap(value as Map<String, dynamic>);
          products.add(tempProduct);
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void filterProducts(String category) {
    filteredProducts =
        products.where((item) => item.category == category).toList();
    notifyListeners();
  }
}

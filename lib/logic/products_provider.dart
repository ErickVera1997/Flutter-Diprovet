import 'package:flutter/cupertino.dart';
import 'package:flutter_diprovet_cliente/core/models/category.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider({required this.productService}) {
    loadProducts();
  }
  final ProductsService productService;
  final List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = false;
  String _selectedCategory = 'Vitaminas';

  final List<Category> categories = [
    const Category('Desparasitante', 'assets/lottie/home/disinfectant.json'),
    const Category('Vitaminas', 'assets/lottie/home/vitamins.json'),
    const Category('Desinfectante', 'assets/lottie/home/dewormer.json'),
    const Category('Antibiótico', 'assets/lottie/home/antibiotic.json'),
    const Category('Relacionados', 'assets/lottie/home/relacionados.json'),
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

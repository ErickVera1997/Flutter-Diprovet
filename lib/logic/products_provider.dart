import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_diprovet_cliente/core/models/category.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsProvider({
    required this.productService,
    bool autoLoad = true,
  }) {
    if (autoLoad) loadProducts();
  }

  final ProductsService productService;

  final List<Category> categories = const [
    Category('Materia Prima', 'assets/lottie/home/disinfectant.json'),
    Category('Mascotas', 'assets/lottie/home/antibiotic.json'),
    Category('Agrícolas', 'assets/lottie/home/vitamins.json'),
    Category('Desinfectante', 'assets/lottie/home/dewormer.json'),
    Category('Relacionados', 'assets/lottie/home/relacionados.json'),
  ];

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Materia Prima';

  List<Product> get products => List.unmodifiable(_products);
  List<Product> get filteredProducts => List.unmodifiable(_filteredProducts);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  set selectedCategory(String selectedCategory) {
    if (_selectedCategory == selectedCategory) return;

    _selectedCategory = selectedCategory;
    _filterProducts();
    notifyListeners();
  }

  Future<void> loadProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await productService.fetchProducts();

    _products = [];
    result.fold(
      (errorMessage) => _errorMessage = errorMessage,
      (productsMap) {
        _products = productsMap.map(Product.fromMap).toList();
      },
    );
    _filterProducts();

    _isLoading = false;
    notifyListeners();
  }

  void _filterProducts() {
    _filteredProducts =
        _products.where((item) => item.category == _selectedCategory).toList();
  }
}

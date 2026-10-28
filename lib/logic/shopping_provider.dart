import 'package:flutter/foundation.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';

class ShoppingProvider extends ChangeNotifier {
  final List<Detail> _details = [];

  List<Detail> get details => List.unmodifiable(_details);

  int get productsCount =>
      _details.fold(0, (sum, detail) => sum + detail.amount);

  double get total => _details.fold(0, (sum, detail) => sum + detail.total);

  bool contains(Product product) => _indexOf(product) != -1;

  Detail? detailFor(Product product) {
    final index = _indexOf(product);

    return index == -1 ? null : _details[index];
  }

  void addProduct(Product product, {int quantity = 1}) {
    if (quantity <= 0) return;

    final index = _indexOf(product);
    if (index == -1) {
      _details.add(Detail(amount: quantity, product: product));
    } else {
      _details[index] = _details[index].copyWith(
        amount: _details[index].amount + quantity,
      );
    }

    notifyListeners();
  }

  /// Reemplaza la cantidad de [product] en el carrito. Si [quantity] es menor
  /// o igual a cero, el producto se elimina.
  void setQuantity(Product product, int quantity) {
    final index = _indexOf(product);
    if (index == -1) {
      if (quantity > 0) addProduct(product, quantity: quantity);

      return;
    }

    if (quantity <= 0) {
      _details.removeAt(index);
    } else {
      _details[index] = _details[index].copyWith(amount: quantity);
    }

    notifyListeners();
  }

  void incrementAmount(Detail detail) =>
      setQuantity(detail.product, detail.amount + 1);

  void decrementAmount(Detail detail) =>
      setQuantity(detail.product, detail.amount - 1);

  void removeProduct(Product product) {
    final index = _indexOf(product);
    if (index == -1) return;

    _details.removeAt(index);
    notifyListeners();
  }

  void clear() {
    if (_details.isEmpty) return;

    _details.clear();
    notifyListeners();
  }

  int _indexOf(Product product) {
    return _details.indexWhere(
      (detail) => product.id.isNotEmpty
          ? detail.product.id == product.id
          : detail.product.name == product.name,
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';

class ShoppingProvider extends ChangeNotifier {
  List<Detail> details = [];

  void addProduct(Product product) {
    final detail = details.firstWhereOrNull(
      (element) => element.product?.name == product.name,
    );

    if (detail != null) {
      final detailUpdate = detail.copyWith(amount: (detail.amount ?? 0) + 1);
      details
        ..removeWhere((element) => element.product?.name == product.name)
        ..add(detailUpdate);
    } else {
      details.add(Detail(1, product));
    }

    notifyListeners();
  }

  void incrementAmount(Detail detail) {
    final index = details.indexWhere(
      (element) => element.product?.name == detail.product?.name,
    );

    if (index != -1) {
      final amountUpdate =
          details[index].copyWith(amount: (detail.amount ?? 0) + 1);
      details[index] = amountUpdate;
    }

    notifyListeners();
  }

  void decrementAmount(Detail detail) {
    final index = details.indexWhere(
      (element) => element.product?.name == detail.product?.name,
    );

    if (index != -1) {
      final amountUpdate =
          details[index].copyWith(amount: (detail.amount ?? 0) - 1);
      details[index] = amountUpdate;

      if ((details[index].amount ?? 0) <= 0) {
        details.removeAt(index);
      }
    }

    notifyListeners();
  }

  void removeProduct(Product product) {
    details.removeWhere((element) => element.product?.name == product.name);
    notifyListeners();
  }

  double totalProducts() {
    return details.fold(0, (sum, detail) => sum + detail.total);
  }
}

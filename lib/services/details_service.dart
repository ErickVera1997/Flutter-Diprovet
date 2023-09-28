import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:flutter_diprovet_cliente/models/shopping_detail.dart';

class DetailService extends ChangeNotifier {
  List<Detail> details = [];

  addProduct(Product product) {
    try {
      final detail =
          details.firstWhere((element) => element.product?.id == product.id);
      final detailUpdate = detail.copyWith(amount: (detail.amount ?? 0) + 1);

      details.removeWhere((element) => element.product?.id == product.id);
      details.add(detailUpdate);
    } catch (e) {
      details.add(
        Detail(
          1,
          product,
        ),
      );
    }
    notifyListeners();
  }

  incrementAmount(Detail detail) {
    final amount = details
        .firstWhere((element) => element.product?.id == detail.product?.id);
    final amountUpdate = amount.copyWith(amount: (detail.amount ?? 0) + 1);
    final index = details
        .indexWhere((element) => element.product?.id == detail.product?.id);
    details.removeWhere((element) => element.product?.id == detail.product?.id);
    details.insert(index, amountUpdate);
    notifyListeners();
  }

  decrementAmount(Detail detail) {
    final amount = details.firstWhere(
      (element) => element.product?.id == detail.product?.id,
      orElse: () => Detail(0, Product()),
    );
    final amountUpdate = amount.copyWith(amount: (detail.amount ?? 0) - 1);
    final index = details
        .indexWhere((element) => element.product?.id == detail.product?.id);
    details.removeWhere((element) => element.product?.id == detail.product?.id);
    details.insert(index, amountUpdate);
    notifyListeners();
  }

  removeProduct(Product product) {
    final index =
        details.indexWhere((element) => element.product?.id == product.id);
    details.removeAt(index);
    notifyListeners();
  }

  double totalProducts() {
    double sum = 0;
    for (var detail in details) {
      sum = sum + detail.total;
    }

    return sum;
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:flutter_diprovet_cliente/models/shopping_detail.dart';

class DetailService extends ChangeNotifier {
  List<Detail> details = [];

  void addProduct(Product product) {
    final detail = details.firstWhereOrNull(
      (element) => element.product?.id == product.id,
    );

    if (detail != null) {
      final detailUpdate = detail.copyWith(amount: (detail.amount ?? 0) + 1);
      details
        ..removeWhere((element) => element.product?.id == product.id)
        ..add(detailUpdate);
    } else {
      details.add(Detail(1, product));
    }

    notifyListeners();
  }

  void incrementAmount(Detail detail) {
    final index = details.indexWhere(
      (element) => element.product?.id == detail.product?.id,
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
      (element) => element.product?.id == detail.product?.id,
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
    details.removeWhere((element) => element.product?.id == product.id);
    notifyListeners();
  }

  double totalProducts() {
    return details.fold(0.0, (sum, detail) => sum + detail.total);
  }
}

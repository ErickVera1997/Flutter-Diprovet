import 'package:flutter_diprovet_cliente/core/models/product.dart';

class Detail {
  const Detail({
    required this.amount,
    required this.product,
  });

  final int amount;
  final Product product;

  Detail copyWith({
    int? amount,
    Product? product,
  }) {
    return Detail(
      amount: amount ?? this.amount,
      product: product ?? this.product,
    );
  }

  double get total => product.price * amount;
}

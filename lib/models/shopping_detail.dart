import 'package:flutter_diprovet_cliente/models/product.dart';

class Detail {
  final int amount;
  final Product product;

  Detail copyWith({
    int? amount,
    Product? product,
  }) {
    return Detail(
      amount ?? this.amount,
      product ?? this.product,
    );
  }

  Detail(this.amount, this.product);

  double get total => product.price * amount;
}

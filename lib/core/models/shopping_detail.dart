import 'package:flutter_diprovet_cliente/core/models/product.dart';

class Detail {
  const Detail(this.amount, this.product);

  final int? amount;
  final Product? product;

  Detail copyWith({
    int? amount,
    Product? product,
  }) {
    return Detail(
      amount ?? this.amount,
      product ?? this.product,
    );
  }

  double get total => product!.price * amount!;
}

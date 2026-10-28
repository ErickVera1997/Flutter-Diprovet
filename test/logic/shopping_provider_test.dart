import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_test/flutter_test.dart';

Product _product({
  String id = '1',
  String name = 'Producto',
  double price = 10000,
}) {
  return Product(
    available: true,
    species: 'Bovino',
    name: name,
    category: 'Materia Prima',
    picture: '',
    price: price,
    description: '',
    details: '',
    share: 0,
    id: id,
  );
}

void main() {
  group('ShoppingProvider', () {
    test('agrega un producto nuevo', () {
      final provider = ShoppingProvider();
      final product = _product();

      provider.addProduct(product);

      expect(provider.details, hasLength(1));
      expect(provider.details.first.amount, 1);
      expect(provider.productsCount, 1);
    });

    test('incrementa la cantidad del mismo producto', () {
      final provider = ShoppingProvider();
      final product = _product();

      provider
        ..addProduct(product)
        ..addProduct(product)
        ..addProduct(product, quantity: 2);

      expect(provider.details, hasLength(1));
      expect(provider.details.first.amount, 4);
      expect(provider.productsCount, 4);
    });

    test('distingue productos con el mismo nombre pero distinto id', () {
      final provider = ShoppingProvider()
        ..addProduct(_product(name: 'Igual'))
        ..addProduct(_product(id: '2', name: 'Igual'));

      expect(provider.details, hasLength(2));
    });

    test('setQuantity reemplaza la cantidad', () {
      final provider = ShoppingProvider();
      final product = _product();

      provider
        ..addProduct(product)
        ..setQuantity(product, 5);

      expect(provider.details.first.amount, 5);
    });

    test('decrementar por debajo de uno elimina el producto', () {
      final provider = ShoppingProvider();
      final product = _product();

      provider
        ..addProduct(product)
        ..decrementAmount(provider.details.first);

      expect(provider.details, isEmpty);
    });

    test('calcula el total del carrito', () {
      final provider = ShoppingProvider()
        ..addProduct(_product(price: 5000), quantity: 2)
        ..addProduct(_product(id: '2', price: 1000));

      expect(provider.total, 11000);
    });

    test('clear vacía el carrito', () {
      final provider = ShoppingProvider()
        ..addProduct(_product())
        ..clear();

      expect(provider.details, isEmpty);
      expect(provider.total, 0);
    });

    test('la lista de detalles no se puede modificar desde fuera', () {
      final provider = ShoppingProvider();

      expect(
        () => provider.details.add(
          Detail(amount: 1, product: _product()),
        ),
        throwsUnsupportedError,
      );
    });
  });
}

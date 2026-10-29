import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product.fromMap', () {
    test('parsea un producto completo', () {
      final product = Product.fromMap(const {
        'id': 'abc',
        'available': true,
        'specie': 'Bovino',
        'name': 'Vitamina B12',
        'category': 'Materia Prima',
        'picture': 'https://example.com/p.png',
        'price': '12500.50',
        'description': 'Descripción',
        'details': 'Detalles',
        'share': '3',
      });

      expect(product.id, 'abc');
      expect(product.available, isTrue);
      expect(product.species, 'Bovino');
      expect(product.name, 'Vitamina B12');
      expect(product.category, 'Materia Prima');
      expect(product.price, 12500.50);
      expect(product.share, 3);
    });

    test('no lanza excepciones con campos ausentes o inválidos', () {
      final product = Product.fromMap(const {
        'price': 'no-es-un-numero',
        'share': null,
      });

      expect(product.id, isEmpty);
      expect(product.name, 'Diprovet');
      expect(product.price, 0);
      expect(product.share, 0);
      expect(product.available, isFalse);
    });

    test('acepta valores numéricos reales', () {
      final product = Product.fromMap(const {'price': 12, 'share': 2.0});

      expect(product.price, 12);
      expect(product.share, 2);
    });
  });
}

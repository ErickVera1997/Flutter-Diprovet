import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeProductsService extends ProductsService {
  _FakeProductsService(this.result) : super(Dio());

  final Either<String, List<Map<String, dynamic>>> result;

  @override
  Future<Either<String, List<Map<String, dynamic>>>> fetchProducts() async {
    return result;
  }
}

Map<String, dynamic> _productMap({
  required String id,
  required String name,
  required String category,
}) {
  return {
    'id': id,
    'name': name,
    'category': category,
    'price': 1000,
  };
}

void main() {
  group('ProductsProvider', () {
    test('carga y filtra por la categoría seleccionada', () async {
      final provider = ProductsProvider(
        autoLoad: false,
        productService: _FakeProductsService(
          right([
            _productMap(
              id: '1',
              name: 'Producto A',
              category: 'Materia Prima',
            ),
            _productMap(
              id: '2',
              name: 'Producto B',
              category: 'Mascotas',
            ),
          ]),
        ),
      );

      await provider.loadProducts();

      expect(provider.isLoading, isFalse);
      expect(provider.errorMessage, isNull);
      expect(provider.products, hasLength(2));
      expect(provider.filteredProducts, hasLength(1));
      expect(provider.filteredProducts.first.id, '1');
    });

    test('vuelve a filtrar al cambiar de categoría', () async {
      final provider = ProductsProvider(
        autoLoad: false,
        productService: _FakeProductsService(
          right([
            _productMap(
              id: '1',
              name: 'Producto A',
              category: 'Materia Prima',
            ),
            _productMap(
              id: '2',
              name: 'Producto B',
              category: 'Mascotas',
            ),
          ]),
        ),
      );

      await provider.loadProducts();
      provider.selectedCategory = 'Mascotas';

      expect(provider.filteredProducts, hasLength(1));
      expect(provider.filteredProducts.first.id, '2');
    });

    test('recargar no duplica productos', () async {
      final provider = ProductsProvider(
        autoLoad: false,
        productService: _FakeProductsService(
          right([
            _productMap(
              id: '1',
              name: 'Producto A',
              category: 'Materia Prima',
            ),
          ]),
        ),
      );

      await provider.loadProducts();
      await provider.loadProducts();

      expect(provider.products, hasLength(1));
    });

    test('expone el error cuando falla la carga', () async {
      final provider = ProductsProvider(
        autoLoad: false,
        productService: _FakeProductsService(left('Sin conexión')),
      );

      await provider.loadProducts();

      expect(provider.isLoading, isFalse);
      expect(provider.errorMessage, 'Sin conexión');
      expect(provider.products, isEmpty);
    });
  });
}

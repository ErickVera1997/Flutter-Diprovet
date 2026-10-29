import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProductsService {
  ProductsService(this.dioClient);

  static const _productsUrl =
      'https://flutter-varios-38eb4-default-rtdb.firebaseio.com/products.json';

  final Dio dioClient;

  Future<Either<String, List<Map<String, dynamic>>>> fetchProducts() async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(_productsUrl);
      final data = response.data ?? const <String, dynamic>{};
      final products = <Map<String, dynamic>>[];

      for (final value in data.values) {
        if (value is Map) {
          products.add(Map<String, dynamic>.from(value));
        }
      }

      return right(products);
    } on DioException catch (err) {
      debugPrint('Error fetching products: $err');

      return left(_messageFor(err));
    } catch (err) {
      debugPrint('Unexpected error fetching products: $err');

      return left('Ocurrió un error inesperado. Inténtalo de nuevo.');
    }
  }

  String _messageFor(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'No se pudo conectar con el servidor. '
            'Verifica tu conexión a internet.';
      case DioExceptionType.badResponse:
        return 'El servidor respondió con un error. Inténtalo más tarde.';
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return 'No se pudieron cargar los productos. Inténtalo de nuevo.';
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductsService {
  ProductsService(this.dioClient);
  final Dio dioClient;

  Future<Either<String, List<dynamic>>> fetchProducts() async {
    try {
      const url =
          'https://flutter-varios-38eb4-default-rtdb.firebaseio.com/products.json';
      final response = await dioClient.get<Map<String, dynamic>>(url);

      return right(response.data?.values.toList() ?? []);
    } on DioException catch (err) {
      debugPrint(err.toString());

      return left('Error del servidor.');
    } catch (err) {
      debugPrint(err.toString());

      return left('Error inesperado.');
    }
  }
}

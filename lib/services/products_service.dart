import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductsService {
  final String _baseUrl = 'flutter-varios-38eb4-default-rtdb.firebaseio.com';

  Future<Map<String, dynamic>> fetchProducts() async {
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}

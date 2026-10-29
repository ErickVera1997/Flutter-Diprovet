import 'package:flutter/foundation.dart';

@immutable
class Product {
  const Product({
    required this.available,
    required this.species,
    required this.name,
    required this.category,
    required this.picture,
    required this.price,
    required this.description,
    required this.details,
    required this.share,
    required this.id,
  });

  /// Crea un [Product] tolerante a datos incompletos o mal tipados.
  ///
  /// Firebase Realtime Database devuelve los valores como `dynamic`, por lo
  /// que un campo ausente o con un formato inesperado no debe tumbar la carga
  /// completa del catálogo.
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: _asString(json['id']),
      available: json['available'] == true,
      species: _asString(json['specie']),
      name: _asString(json['name'], fallback: 'Diprovet'),
      category: _asString(json['category']),
      picture: _asString(json['picture']),
      price: _asDouble(json['price']),
      description: _asString(json['description'], fallback: 'Diprovet'),
      details: _asString(json['details']),
      share: _asInt(json['share']),
    );
  }

  final bool available;
  final String species;
  final int share;
  final String name;
  final String category;
  final String picture;
  final String details;
  final String description;
  final double price;
  final String id;

  Product copy() => Product(
        available: available,
        species: species,
        name: name,
        category: category,
        picture: picture,
        price: price,
        description: description,
        details: details,
        share: share,
        id: id,
      );

  static String _asString(Object? value, {String fallback = ''}) {
    final text = value?.toString().trim();

    return text == null || text.isEmpty ? fallback : text;
  }

  static double _asDouble(Object? value) {
    return num.tryParse(value?.toString() ?? '')?.toDouble() ?? 0;
  }

  static int _asInt(Object? value) {
    return int.tryParse(value?.toString() ?? '') ??
        num.tryParse(value?.toString() ?? '')?.toInt() ??
        0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

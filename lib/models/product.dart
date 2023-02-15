import 'dart:convert';

class Product {
  Product({
    required this.available,
    required this.specie,
    required this.name,
    required this.category,
    required this.picture,
    required this.price,
    required this.description,
    required this.details,
    required this.share,
    this.id,
  });

  bool available;
  String specie;
  int share;
  String name;
  String category;
  String picture;
  String details;
  String description;
  double price;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json['available'],
        specie: json['specie'],
        name: json['name'],
        category: json['category'],
        picture: json['picture'],
        price: json['price'],
        description: json['description'],
        details: json['details'],
        share: json['share'],
      );

  Map<String, dynamic> toMap() => {
        'available': available,
        'specie': specie,
        'name': name,
        'category': category,
        'picture': picture,
        'price': price,
        'details': details,
        'description': description,
        'share': share,
      };

  Product copy() => Product(
        available: available,
        specie: specie,
        name: name,
        category: category,
        picture: picture,
        price: price,
        description: description,
        details: details,
        share: share,
        id: id,
      );
  String get categoria => category;
}

class Product {
  Product({
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

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: (json['id'] ?? '').toString(),
        available: json['available'] as bool? ?? false,
        species: (json['specie'] ?? '').toString(),
        name: (json['name'] ?? 'Diprovet').toString(),
        category: (json['category'] ?? '').toString(),
        picture: (json['picture'] ?? '').toString(),
        price: double.parse(json['price']?.toString() ?? '.0'),
        description: (json['description'] ?? 'Diprovet').toString(),
        details: (json['details'] ?? '').toString(),
        share: int.parse(json['share']?.toString() ?? ''),
      );

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
}

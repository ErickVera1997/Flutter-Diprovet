class Product {
  Product({
    this.available,
    this.species,
    this.name,
    this.category,
    this.picture,
    this.price,
    this.description,
    this.details,
    this.share,
    this.id,
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

  bool? available;
  String? species;
  int? share;
  String? name;
  String? category;
  String? picture;
  String? details;
  String? description;
  double? price;
  String? id;

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

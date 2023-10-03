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

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json['available'] ?? false,
        species: json['specie'] ?? '',
        name: json['name'] ?? 'Diprovet',
        category: json['category'] ?? '',
        picture: json['picture'] ?? '',
        price: json['price'] ?? .0,
        description: json['description'] ?? '',
        details: json['details'] ?? '',
        share: json['share'] ?? '',
      );

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
  String get categoryGet => category ?? '';
}

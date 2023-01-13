import 'dart:convert';

class Product {
  String? id;
  String catId;
  String name;
  String description;
  String price;
  String imageUrl;
  int quantity;
  Product({
    this.id,
    required this.catId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'catId': catId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      catId: map['catId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    String? id,
    String? catId,
    String? name,
    String? description,
    String? price,
    String? imageUrl,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      catId: catId ?? this.catId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, catId: $catId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id &&
      other.catId == catId &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.imageUrl == imageUrl &&
      other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      catId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      quantity.hashCode;
  }
}

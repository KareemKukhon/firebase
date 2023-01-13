import 'dart:convert';

import 'package:flutter/foundation.dart';

class Cart {
  String? id;
  num count;
  String? product_id;
  num price;
  Cart({
    this.id,
    required this.product_id,
    required this.count,
    required this.price,
  });

  Cart copyWith({
    String? id,
    num? count,
    List<String>? products_Id,
    String? product_id,
    num? price,
  }) {
    return Cart(
      id: id ?? this.id,
      count: count ?? this.count,
      product_id: product_id ?? this.product_id,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'product_id': product_id,
      'price': price,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      count: map['count'] ?? 0,
      product_id: map['product_id'] ?? '',
      price: map['price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, count: $count, product_id: $product_id, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.id == id &&
        other.count == count &&
        other.product_id == product_id &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        count.hashCode ^
        product_id.hashCode ^
        price.hashCode;
  }
}

import 'dart:convert';

import 'package:tameer/data/models/product.dart';

class Category {
  final String documentId;
  final String name;
  final String image;
  final List<Product> products;

  Category({required this.documentId, required this.name, required this.image, required this.products});

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'name': name,
      'image': image,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      documentId: map['documentId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      products: List<Product>.from((map['products'] ?? []).map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));
}

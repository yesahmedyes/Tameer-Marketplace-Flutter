import 'dart:convert';

class Product {
  final String documentId;
  final String name;
  final String image;
  final int price;
  final String unit;
  final int ordered;
  final int retailPrice;

  Product({required this.documentId, required this.name, required this.image, required this.price, required this.unit, required this.ordered, required this.retailPrice});

  Map<String, dynamic> toMap() {
    return {
      'documentId': documentId,
      'name': name,
      'image': image,
      'price': price,
      'unit': unit,
      'ordered': ordered,
      'retailPrice': retailPrice,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      documentId: map['documentId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
      ordered: map['ordered']?.toInt() ?? 0,
      retailPrice: map['retailPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}

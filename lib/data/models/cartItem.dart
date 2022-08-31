import 'dart:convert';

class CartItem {
  final String categoryId;
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final int price;

  CartItem({required this.categoryId, required this.productId, required this.productName, required this.productImage, required this.quantity, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      categoryId: map['categoryId'] ?? '',
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));
}

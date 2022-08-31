import 'package:tameer/data/models/cartItem.dart';

class Cart {
  final List<CartItem> items;
  final String message;

  Cart({required this.items, required this.message});
}

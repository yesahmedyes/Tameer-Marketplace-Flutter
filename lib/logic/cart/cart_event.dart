part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartCheckStatusEvent extends CartEvent {}

class CartUpdateEvent extends CartEvent {
  final String categoryId;
  final String productId;
  final String productName;
  final String productImage;
  final int quantity;
  final int price;

  const CartUpdateEvent({required this.categoryId, required this.productId, required this.quantity, required this.productName, required this.productImage, required this.price});

  @override
  List<Object> get props => [categoryId, productId, quantity, productName, productImage];
}

class CartUpdateCompleteEvent extends CartEvent {
  final List<CartItem> items;
  final String message;

  const CartUpdateCompleteEvent({required this.items, required this.message});

  @override
  List<Object> get props => [items];
}

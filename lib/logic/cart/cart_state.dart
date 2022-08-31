part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}

class CartOpenedState extends CartState {
  final List<CartItem> items;

  const CartOpenedState({required this.items});

  @override
  List<Object> get props => [items];
}

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductOpenedState extends ProductState {
  final List<Product> products;
  final String categoryId;

  const ProductOpenedState({required this.products, required this.categoryId});

  @override
  List<Object> get props => [products, categoryId];
}

class ProductFailedState extends ProductState {
  final String error;

  const ProductFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

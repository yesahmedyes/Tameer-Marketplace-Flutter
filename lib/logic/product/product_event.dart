part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductOpenEvent extends ProductEvent {
  final String documentId;

  const ProductOpenEvent({required this.documentId});

  @override
  List<Object> get props => [documentId];
}

class ProductOpenSuccessEvent extends ProductEvent {
  final List<Product> products;
  final String categoryId;

  const ProductOpenSuccessEvent({required this.products, required this.categoryId});

  @override
  List<Object> get props => [products, categoryId];
}

class ProductOpenFailedEvent extends ProductEvent {
  final String error;

  const ProductOpenFailedEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class ProductCloseEvent extends ProductEvent {}

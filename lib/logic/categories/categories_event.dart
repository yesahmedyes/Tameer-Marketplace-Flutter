part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoriesFetchEvent extends CategoriesEvent {}

class CategoriesFetchSuccessEvent extends CategoriesEvent {
  final List<Category> categories;

  const CategoriesFetchSuccessEvent({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesFetchFailedEvent extends CategoriesEvent {
  final String error;

  const CategoriesFetchFailedEvent({required this.error});

  @override
  List<Object> get props => [error];
}

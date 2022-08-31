part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitialState extends CategoriesState {}

class CategoriesFetchingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<Category> categories;

  const CategoriesSuccessState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoriesFailedState extends CategoriesState {
  final String error;

  const CategoriesFailedState({required this.error});

  @override
  List<Object> get props => [error];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tameer/data/models/category.dart';
import 'package:tameer/data/repositories/productsRepository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductsRepository _categoryRepository;

  CategoriesBloc({required ProductsRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoriesInitialState()) {
    on<CategoriesFetchEvent>(_onFetch);
    on<CategoriesFetchSuccessEvent>(_onSuccess);
    on<CategoriesFetchFailedEvent>(_onFailed);
  }

  void _onFetch(CategoriesFetchEvent event, Emitter<CategoriesState> emit) async {
    final List<Category> categories = await _categoryRepository.fetchCategories();

    if (categories.isEmpty) {
      add(const CategoriesFetchFailedEvent(error: 'Failed to load. Please try again later'));
    } else {
      add(CategoriesFetchSuccessEvent(categories: categories));
    }
  }

  void _onSuccess(CategoriesFetchSuccessEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesSuccessState(categories: event.categories));
  }

  void _onFailed(CategoriesFetchFailedEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesFailedState(error: event.error));
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tameer/data/models/product.dart';
import 'package:tameer/data/repositories/productsRepository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository _categoryRepository;

  ProductBloc({required ProductsRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(ProductInitialState()) {
    on<ProductOpenEvent>(_onOpen);
    on<ProductOpenSuccessEvent>(_onOpenSuccess);
    on<ProductOpenFailedEvent>(_onOpenFailed);
    on<ProductCloseEvent>(_onClose);
  }

  void _onOpen(ProductOpenEvent event, Emitter<ProductState> emit) async {
    final List<Product> products = await _categoryRepository.fetchProducts(event.documentId);

    add(ProductOpenSuccessEvent(products: products, categoryId: event.documentId));
  }

  void _onOpenSuccess(ProductOpenSuccessEvent event, Emitter<ProductState> emit) async {
    emit(ProductOpenedState(products: event.products, categoryId: event.categoryId));
  }

  void _onOpenFailed(ProductOpenFailedEvent event, Emitter<ProductState> emit) async {
    emit(ProductFailedState(error: event.error));
  }

  void _onClose(ProductCloseEvent event, Emitter<ProductState> emit) async {
    emit(ProductInitialState());
  }
}

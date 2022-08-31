import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tameer/data/models/cart.dart';
import 'package:tameer/data/models/cartItem.dart';
import 'package:tameer/data/repositories/cartRepository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  StreamSubscription? subscription;

  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartInitialState()) {
    on<CartCheckStatusEvent>(_onCheckStatus);
    on<CartUpdateEvent>(_onUpdate);
    on<CartUpdateCompleteEvent>(_onUpdateComplete);
  }

  _onCheckStatus(CartCheckStatusEvent event, Emitter<CartState> emit) async {
    final Cart _cart = await _cartRepository.fetchCart();

    emit(CartOpenedState(items: _cart.items));
  }

  _onUpdate(CartUpdateEvent event, Emitter<CartState> emit) async {
    subscription ??= _cartRepository.stream.listen((cart) {
      add(CartUpdateCompleteEvent(items: cart.items, message: cart.message));
    });

    final Map<String, dynamic> _data = {
      'categoryId': event.categoryId,
      'productId': event.productId,
      'productName': event.productName,
      'productImage': event.productImage,
      'quantity': event.quantity,
      'price': event.price,
    };

    _cartRepository.updateCart(data: _data);
  }

  _onUpdateComplete(CartUpdateCompleteEvent event, Emitter<CartState> emit) {
    if (event.message.isNotEmpty) {
      Fluttertoast.showToast(msg: event.message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    }
    emit(CartOpenedState(items: event.items));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}

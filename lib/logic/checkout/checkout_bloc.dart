import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tameer/data/models/cart.dart';
import 'package:tameer/data/repositories/cartRepository.dart';
import 'package:tameer/data/repositories/ordersRepository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartRepository _cartRepository;
  final OrdersRepository _ordersRepository;

  CheckoutBloc({required CartRepository cartRepository, required OrdersRepository ordersRepository})
      : _cartRepository = cartRepository,
        _ordersRepository = ordersRepository,
        super(CheckoutInitialState()) {
    on<CheckoutChangeEvent>(_onChange);
    on<CheckoutSubmitEvent>(_onSubmit);
    on<CheckoutSubmitSuccessEvent>(_onSuccess);
    on<CheckoutSubmitFailedEvent>(_onFailed);
  }

  void _onChange(CheckoutChangeEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutOpenedState(address: event.address));
  }

  void _onSubmit(CheckoutSubmitEvent event, Emitter<CheckoutState> emit) async {
    final String address = state.props.first as String;

    emit(CheckoutSubmittingState());

    final Cart cart = await _cartRepository.fetchCart();

    final submitted = await _ordersRepository.placeOrder(address, cart.items);

    if (submitted) {
      add(CheckoutSubmitSuccessEvent());
    } else {
      add(CheckoutSubmitFailedEvent());
    }
  }

  void _onSuccess(CheckoutSubmitSuccessEvent event, Emitter<CheckoutState> emit) {
    _cartRepository.emptyCart();
    emit(CheckoutCompletedState());
    Fluttertoast.showToast(msg: 'Order placed', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
  }

  void _onFailed(CheckoutSubmitFailedEvent event, Emitter<CheckoutState> emit) {
    Fluttertoast.showToast(msg: 'Order could not be placed. Please try again later.', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
  }
}

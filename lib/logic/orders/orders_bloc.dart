import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tameer/data/repositories/ordersRepository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersBloc({required OrdersRepository ordersRepository})
      : _ordersRepository = ordersRepository,
        super(OrdersInitialState()) {
    on<OrdersFetchEvent>(_onFetch);
    on<OrdersFetchSuccessEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OrdersFetchFailedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  void _onFetch(OrdersFetchEvent event, Emitter<OrdersState> emit) async {
    await _ordersRepository.fetchOrders();
  }
}

part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class OrdersFetchEvent extends OrdersEvent {}

class OrdersFetchSuccessEvent extends OrdersEvent {
  const OrdersFetchSuccessEvent();

  @override
  List<Object> get props => [];
}

class OrdersFetchFailedEvent extends OrdersEvent {
  final String error;

  const OrdersFetchFailedEvent({required this.error});

  @override
  List<Object> get props => [error];
}

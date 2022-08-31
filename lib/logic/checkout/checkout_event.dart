part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutChangeEvent extends CheckoutEvent {
  final String address;

  const CheckoutChangeEvent({this.address = ''});

  @override
  List<Object> get props => [address];
}

class CheckoutSubmitEvent extends CheckoutEvent {}

class CheckoutSubmitSuccessEvent extends CheckoutEvent {}

class CheckoutSubmitFailedEvent extends CheckoutEvent {}

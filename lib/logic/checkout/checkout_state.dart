part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitialState extends CheckoutState {}

class CheckoutOpenedState extends CheckoutState {
  final String address;

  const CheckoutOpenedState({required this.address});

  @override
  List<Object> get props => [address];
}

class CheckoutSubmittingState extends CheckoutState {}

class CheckoutCompletedState extends CheckoutState {}

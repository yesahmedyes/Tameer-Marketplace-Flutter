part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupInitializeStreamEvent extends SignupEvent {}

class SignupCheckStatusEvent extends SignupEvent {}

class SignupChangeToInitialEvent extends SignupEvent {}

class SignupCompleteEvent extends SignupEvent {
  final Profile profile;

  const SignupCompleteEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

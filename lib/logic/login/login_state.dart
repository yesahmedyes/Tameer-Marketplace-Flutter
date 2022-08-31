part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginCheckingStatusState extends LoginState {}

class LoginPhoneSentState extends LoginState {}

class LoginOtpWaitingState extends LoginState {}

class LoginOtpVerifyingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final User? firebaseUser;

  LoginSuccessState({required this.firebaseUser});

  @override
  List<Object?> get props => [firebaseUser];
}

class LoginFailedState extends LoginState {
  final String error;

  LoginFailedState({required this.error});

  @override
  List<Object?> get props => [error];
}

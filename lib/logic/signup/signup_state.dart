part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupCheckingStatusState extends SignupState {}

class SignupSuccessState extends SignupState {
  final Profile profile;

  const SignupSuccessState(this.profile);

  @override
  List<Object> get props => [profile];
}

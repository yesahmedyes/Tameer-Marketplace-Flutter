part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginCheckStatusEvent extends LoginEvent {}

class LoginSendPhoneEvent extends LoginEvent {
  final String phoneNumber;

  LoginSendPhoneEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class LoginDemandOtpEvent extends LoginEvent {}

class LoginForceRedemandOtpEvent extends LoginEvent {}

class LoginSendOtpEvent extends LoginEvent {
  final String otp;

  LoginSendOtpEvent({required this.otp});

  @override
  List<Object?> get props => [otp];
}

class LoginCompleteEvent extends LoginEvent {
  final User user;

  LoginCompleteEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailedEvent extends LoginEvent {
  final String error;

  LoginFailedEvent({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginSetToInitialEvent extends LoginEvent {}

class LoginLogoutEvent extends LoginEvent {}

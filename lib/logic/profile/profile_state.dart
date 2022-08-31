part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileFormOpenState extends ProfileState {
  final String type;

  const ProfileFormOpenState(this.type);

  @override
  List<Object> get props => [type];
}

class ProfileUploadingState extends ProfileState {}

class ProfileUploadSuccessState extends ProfileState {}

class ProfileUploadFailedState extends ProfileState {
  final String error;

  const ProfileUploadFailedState(this.error);

  @override
  List<Object> get props => [error];
}

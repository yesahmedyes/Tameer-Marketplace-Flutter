part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileFormOpenEvent extends ProfileEvent {}

class ProfileFormCloseEvent extends ProfileEvent {}

class ProfileUploadEvent extends ProfileEvent {
  final Map<String, dynamic> data;

  const ProfileUploadEvent(this.data);

  @override
  List<Object> get props => [data];
}

class ProfileTypeChangeEvent extends ProfileEvent {
  final String type;

  const ProfileTypeChangeEvent({required this.type});

  @override
  List<Object> get props => [type];
}

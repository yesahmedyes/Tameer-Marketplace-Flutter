import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tameer/data/models/profile.dart';
import 'package:tameer/data/repositories/profileRepository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ProfileInitialState()) {
    on<ProfileFormOpenEvent>(_onFormOpen);

    on<ProfileFormCloseEvent>(_onFormClose);

    on<ProfileTypeChangeEvent>(_onTypeChange);

    on<ProfileUploadEvent>(_onProfileUpload);
  }

  void _onFormOpen(ProfileFormOpenEvent event, Emitter<ProfileState> emit) {
    if (_profileRepository.profile != null && _profileRepository.profile!.type.isNotEmpty) {
      emit(ProfileFormOpenState(_profileRepository.profile!.type));
    } else {
      emit(const ProfileFormOpenState('Individual'));
    }
  }

  void _onFormClose(ProfileFormCloseEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitialState());
  }

  void _onTypeChange(ProfileTypeChangeEvent event, Emitter<ProfileState> emit) {
    if (state is ProfileFormOpenState) {
      emit(ProfileFormOpenState(event.type));
    }
  }

  void _onProfileUpload(ProfileUploadEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUploadingState());

    final Profile? _profile = await _profileRepository.uploadProfile(event.data);

    if (_profile != null) {
      emit(ProfileUploadSuccessState());
      Fluttertoast.showToast(msg: 'Profile saved', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
    } else {
      emit(const ProfileUploadFailedState("Upload failed. Please restart the app and try again later"));
    }
  }
}

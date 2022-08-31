import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tameer/data/models/profile.dart';
import 'package:tameer/data/repositories/profileRepository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final ProfileRepository _profileRepository;
  StreamSubscription? subscription;

  SignupBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(SignupInitialState()) {
    on<SignupInitializeStreamEvent>(_onInitializeStream);
    on<SignupCheckStatusEvent>(_onCheckStatus);
    on<SignupChangeToInitialEvent>(_onChangeToInitial);
    on<SignupCompleteEvent>(_onComplete);
  }

  void _onInitializeStream(SignupInitializeStreamEvent event, Emitter<SignupState> emit) {
    subscription ??= _profileRepository.stream.listen(
      (Profile? data) {
        if (data == null && state is! SignupInitialState) {
          add(SignupChangeToInitialEvent());
        } else if (data != null) {
          add(SignupCompleteEvent(data));
        }
      },
    );
  }

  void _onCheckStatus(SignupCheckStatusEvent event, Emitter<SignupState> emit) async {
    emit(SignupCheckingStatusState());

    await _profileRepository.fetchProfile();
  }

  void _onChangeToInitial(SignupChangeToInitialEvent event, Emitter<SignupState> emit) {
    emit(SignupInitialState());
  }

  void _onComplete(SignupCompleteEvent event, Emitter<SignupState> emit) {
    emit(SignupSuccessState(event.profile));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tameer/data/repositories/authRepository.dart';
import 'package:tameer/data/repositories/profileRepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  String? phoneNumber;
  String? verificationId;
  int? resendToken;

  LoginBloc({required AuthRepository authRepository, required ProfileRepository profileRepository})
      : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(LoginInitialState()) {
    on<LoginCheckStatusEvent>(_onCheckStatus);
    on<LoginSendPhoneEvent>(_onSendPhoneEvent);
    on<LoginDemandOtpEvent>(_onDemandOtp);
    on<LoginForceRedemandOtpEvent>(_onForceRedemandOtp);
    on<LoginSendOtpEvent>(_onSendOtp);
    on<LoginCompleteEvent>(_onComplete);
    on<LoginFailedEvent>(_onFailed);
    on<LoginSetToInitialEvent>(_onSetToInitial);
    on<LoginLogoutEvent>(_onLogout);
  }

  void _onCheckStatus(LoginCheckStatusEvent event, Emitter<LoginState> emit) {
    emit(LoginCheckingStatusState());

    final User? user = _authRepository.user;

    if (user != null) {
      add(LoginCompleteEvent(user: user));
    } else {
      verificationId = null;
      resendToken = null;
      phoneNumber = null;
      add(LoginSetToInitialEvent());
    }
  }

  void _onSendPhoneEvent(LoginSendPhoneEvent event, Emitter<LoginState> emit) {
    emit(LoginPhoneSentState());
    phoneNumber = event.phoneNumber;
    sendOtp();
  }

  void _onDemandOtp(LoginDemandOtpEvent event, Emitter<LoginState> emit) {
    emit(LoginOtpWaitingState());
  }

  void _onForceRedemandOtp(LoginForceRedemandOtpEvent event, Emitter<LoginState> emit) {
    emit(LoginPhoneSentState());
    sendOtp();
  }

  void _onSendOtp(LoginSendOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginOtpVerifyingState());
    final user = await _authRepository.verifyAndLogin(verificationId!, event.otp);
    if (user != null) {
      add(LoginCompleteEvent(user: user));
    } else {
      add(LoginFailedEvent(error: "The code you entered was incorrect"));
    }
  }

  void _onComplete(LoginCompleteEvent event, Emitter<LoginState> emit) async {
    emit(LoginSuccessState(firebaseUser: event.user));
  }

  void _onFailed(LoginFailedEvent event, Emitter<LoginState> emit) {
    verificationId = null;
    resendToken = null;
    phoneNumber = null;
    emit(LoginFailedState(error: event.error));
  }

  void _onSetToInitial(LoginSetToInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  void _onLogout(LoginLogoutEvent event, Emitter<LoginState> emit) async {
    await _authRepository.signOut();
    await _profileRepository.removeProfileLocally();
    add(LoginCheckStatusEvent());
  }

  Future<void> sendOtp() async {
    Future<void> verificationComplete(PhoneAuthCredential credential) async {
      try {
        await _authRepository.automaticSignIn(credential);
        var user = _authRepository.user;
        if (user != null) add(LoginCompleteEvent(user: user));
      } catch (error) {
        add(LoginFailedEvent(error: 'Failed to Login. Please restart the app and try again later'));
      }
    }

    void verificationFailed(FirebaseAuthException e) {
      add(LoginFailedEvent(error: e.message ?? ''));
    }

    void codeSent(String verificationId, int? resendToken) async {
      this.verificationId = verificationId;
      this.resendToken = resendToken;

      add(LoginDemandOtpEvent());
    }

    void codeAutoRetrievalTimeout(String verificationId) {}

    await _authRepository.sendCode(
      phoneNumber!,
      const Duration(seconds: 60),
      verificationFailed,
      verificationComplete,
      codeSent,
      codeAutoRetrievalTimeout,
      resendToken,
    );
  }
}

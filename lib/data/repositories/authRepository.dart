import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> sendCode(
    String phoneNumber,
    Duration timeOut,
    PhoneVerificationFailed verificationFailed,
    PhoneVerificationCompleted verificationCompleted,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    int? forceResendingToken,
  ) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: forceResendingToken,
    );
  }

  Future<void> automaticSignIn(PhoneAuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  Future<User?> verifyAndLogin(String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    UserCredential credential;

    try {
      credential = await _firebaseAuth.signInWithCredential(authCredential);
    } catch (error) {
      return null;
    }

    return credential.user;
  }

  User? get user {
    return _firebaseAuth.currentUser;
  }
}

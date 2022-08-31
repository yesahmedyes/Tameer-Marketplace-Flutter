import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:tameer/data/models/profile.dart';

class ProfileRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Profile? profile;

  final _controller = StreamController<Profile?>();

  Stream<Profile?> get stream => _controller.stream;

  Future<Profile?> _saveAndReturn(Map<String, dynamic>? map) async {
    if (map == null) {
      _controller.sink.add(null);
      return null;
    } else {
      var box = await Hive.openBox("tameer");
      box.put('profile', map);

      profile = Profile.fromMap(map);

      _controller.sink.add(profile);

      return profile;
    }
  }

  Future<Profile?> fetchProfile() async {
    var box = await Hive.openBox("tameer");
    final _map = box.get('profile');

    if (_map != null) {
      return await _saveAndReturn(Map<String, dynamic>.from(_map));
    } else {
      final User? _user = _firebaseAuth.currentUser;
      if (_user != null) {
        final uid = _user.uid;
        final _snapshot = await _firestore.collection('profiles').doc(uid).get();
        final _data = _snapshot.data();
        if (_data != null) {
          return await _saveAndReturn(_data);
        }
      }
    }

    return await _saveAndReturn(null);
  }

  Future<void> removeProfileLocally() async {
    var box = await Hive.openBox("tameer");
    box.delete('profile');
    _controller.sink.add(null);
  }

  Future<Profile?> uploadProfile(Map<String, dynamic> map) async {
    final uid = _firebaseAuth.currentUser!.uid;

    await _firestore.collection('profiles').doc(uid).set(map);

    return await _saveAndReturn(map);
  }
}

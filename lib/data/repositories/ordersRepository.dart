import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tameer/data/models/cartItem.dart';

class OrdersRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  OrdersRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> fetchOrders() async {
    final User? _user = _firebaseAuth.currentUser;
    final QuerySnapshot _snapshot = await _firestore.collection("orders").where("prodileId", isEqualTo: _user!.uid).get();
  }

  Future<bool> placeOrder(String address, List<CartItem> cart) async {
    final User? _user = _firebaseAuth.currentUser;

    final Map<String, dynamic> _data = {
      'profileId': _user!.uid,
      'phoneNumber': _user.phoneNumber,
      'address': address,
      'paymentMethod': 'cash on delivery',
      'items': cart.map((e) => e.toMap()).toList(),
      'status': 'pending',
    };

    try {
      await _firestore.collection("orders").add(_data);
      return true;
    } catch (error) {
      return false;
    }
  }
}

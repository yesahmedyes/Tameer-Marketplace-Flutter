import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tameer/data/models/cart.dart';
import 'package:tameer/data/models/cartItem.dart';

class CartRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  CartRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final _controller = StreamController<Cart>();

  Stream<Cart> get stream => _controller.stream;

  final Map<String, CartItem> _cart = {};

  Future<Cart> fetchCart() async {
    if (_cart.isEmpty) {
      final User? _user = _firebaseAuth.currentUser;

      final DocumentSnapshot _snapshot = await _firestore.collection('cart').doc(_user!.uid).get();

      final data = _snapshot.data();

      if (data != null) {
        final Map values = data as Map;

        final List _items = values['items'];

        for (var element in _items) {
          _cart[element['productId']] = CartItem.fromMap(element);
        }
      }
    }

    return Cart(items: _cart.values.toList(), message: '');
  }

  void updateCartInFirebase(final Map<String, CartItem> oldCart) async {
    final User? _user = _firebaseAuth.currentUser;

    _controller.sink.add(Cart(items: _cart.values.toList(), message: "Product added to cart"));

    try {
      await _firestore.collection("cart").doc(_user!.uid).set({"items": _cart.values.map((e) => e.toMap()).toList()});
    } catch (error) {
      _cart.clear();
      _cart.addAll(oldCart);
      _controller.sink.add(Cart(items: _cart.values.toList(), message: "Error occured while adding product to cart"));
    }
  }

  Future<void> updateCart({required final Map<String, dynamic> data, final bool overWrite = false}) async {
    final Map<String, CartItem> _oldCart = Map.from(_cart);

    if (_cart.containsKey(data['productId']) && overWrite == false) {
      _cart[data['productId']] = CartItem.fromMap(data);
    } else {
      _cart[data['productId']] = CartItem.fromMap(data);
    }

    updateCartInFirebase(_oldCart);
  }

  Future<void> emptyCart() async {
    final User? _user = _firebaseAuth.currentUser;

    _cart.clear();
    _controller.sink.add(Cart(items: _cart.values.toList(), message: ""));

    await _firestore.collection("cart").doc(_user!.uid).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tameer/data/models/category.dart';
import 'package:tameer/data/models/product.dart';

class ProductsRepository {
  final FirebaseFirestore _firestore;

  ProductsRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final Map<String, Category> _categories = {};

  Future<List<Category>> fetchCategories() async {
    final QuerySnapshot _snapshot = await _firestore.collection('categories').where("active", isEqualTo: true).get();

    for (var each in _snapshot.docs) {
      final _data = each.data() as Map<String, dynamic>;
      _data['documentId'] = each.id;
      _categories[each.id] = Category.fromMap(_data);
    }

    return _categories.values.toList();
  }

  Future<List<Product>> fetchProducts(String documentId) async {
    if (_categories[documentId]!.products.isEmpty) {
      final QuerySnapshot _snapshot = await _firestore.collection('categories').doc(documentId).collection('products').where("active", isEqualTo: true).get();

      for (var each in _snapshot.docs) {
        final _data = each.data() as Map<String, dynamic>;
        _data['documentId'] = each.id;
        _categories[documentId]!.products.add(Product.fromMap(_data));
      }
    }

    return _categories[documentId]!.products.toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/models.dart';
import 'package:delivery_app/repositories/product/base_product_repo.dart';

class ProductRepo extends BaseProductRepo {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('products').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromSnapshor(doc)).toList());
  }
}

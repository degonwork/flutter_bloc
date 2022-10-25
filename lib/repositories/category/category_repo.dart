import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/category_model.dart';
import 'package:delivery_app/repositories/category/base_category_repo.dart';

class CategoryRepo extends BaseCategoryRepo {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList());
  }
}

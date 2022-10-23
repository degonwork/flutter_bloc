import 'package:delivery_app/models/category_model.dart';

abstract class BaseCategoryRepo {
  Stream<List<Category>> getAllCatgories();
}

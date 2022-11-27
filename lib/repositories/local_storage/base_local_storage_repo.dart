import 'package:hive_flutter/hive_flutter.dart';

import '../../models/models.dart';

abstract class BaseLocalStorageRepo {
  Future<Box> openBox();
  List<Product> getWishList(Box box);
  Future<void> addProductToWishlist(Box box, Product product);
  Future<void> removeProductToWishlist(Box box, Product product);
  Future<void> clearWishlist(Box box);
}

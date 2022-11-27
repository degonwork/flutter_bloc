import 'package:delivery_app/models/product_model.dart';
import 'package:delivery_app/repositories/local_storage/base_local_storage_repo.dart';
import 'package:hive/hive.dart';

class LocalStorageRepo extends BaseLocalStorageRepo {
  String boxName = 'Wishlist_products';
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }

  @override
  List<Product> getWishList(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductToWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}

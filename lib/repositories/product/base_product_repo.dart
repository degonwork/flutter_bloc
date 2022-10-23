import 'package:delivery_app/models/models.dart';

abstract class BaseProductRepo {
  Stream<List<Product>> getAllProducts();
}

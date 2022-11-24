import '../../models/models.dart';

abstract class BaseCheckoutRepo {
  Future<void> addCheckout(Checkout checkOut);
}

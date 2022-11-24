import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/models.dart';
import 'package:delivery_app/repositories/checkout/base_checkout_repo.dart';

class CheckoutRepo extends BaseCheckoutRepo {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addCheckout(Checkout checkOut) {
    return _firebaseFirestore.collection('checkout').add(checkOut.toDocument());
  }
}

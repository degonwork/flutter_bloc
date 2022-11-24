import 'package:delivery_app/models/models.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({this.products = const <Product>[]});
  final List<Product> products;
  double get subTotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFree(subTotal) {
    if (subTotal >= 30) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 30) {
      return "You have Free delivery";
    } else {
      double missing = 30.00 - subTotal;
      return "Add \$${missing.toStringAsFixed(2)} For Free Delivery";
    }
  }

  double total(subTotal, deliveryFree) {
    return subTotal + deliveryFree(subTotal);
  }

  String get subTotalString => subTotal.toStringAsFixed(2);
  String get deliveryFreeString => deliveryFree(subTotal).toStringAsFixed(2);
  String get deliveryFeeString => freeDelivery(subTotal);
  String get totalString => total(subTotal, deliveryFree).toStringAsFixed(2);

  Map productQuantity(List<Product> listProducts) {
    var quantity = Map();
    listProducts.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  @override
  List<Object?> get props => [products];
}

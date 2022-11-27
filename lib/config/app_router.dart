import 'package:delivery_app/models/category_model.dart';
import 'package:delivery_app/screens/order/order_comfirmation.dart';
import 'package:delivery_app/screens/payment/payment_selection.dart';
import 'package:delivery_app/screens/screens.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print("This is route: ${settings.name}");
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case WishListScreen.routeName:
        return WishListScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CheckOutScreen.routeName:
        return CheckOutScreen.route();
      case OrderComfirmationScreen.routeName:
        return OrderComfirmationScreen.route();
      case PaymentSelectionScreen.routeName:
        return PaymentSelectionScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('error'),
        ),
      ),
    );
  }
}

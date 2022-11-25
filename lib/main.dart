import 'package:delivery_app/blocs/cart/cart_bloc.dart';
import 'package:delivery_app/blocs/category/category_bloc.dart';
import 'package:delivery_app/blocs/checkout/checkout_bloc.dart';
import 'package:delivery_app/blocs/payment/payment_bloc.dart';
import 'package:delivery_app/blocs/product/product_bloc.dart';
import 'package:delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:delivery_app/config/app_router.dart';
import 'package:delivery_app/config/theme.dart';
import 'package:delivery_app/repositories/category/category_repo.dart';
import 'package:delivery_app/repositories/checkout/checkout_repo.dart';
import 'package:delivery_app/repositories/product/product_repo.dart';
import 'package:delivery_app/screens/order/order_comfirmation.dart';
import 'package:delivery_app/screens/payment/payment_selection.dart';
import 'package:delivery_app/screens/screens.dart';
import 'package:delivery_app/simple_bloc_observer.dart';
// import 'package:delivery_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(StartWishList())),
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
        BlocProvider(
            create: (context) => CheckoutBloc(
                  cartBloc: context.read<CartBloc>(),
                  checkoutRepo: CheckoutRepo(),
                  paymentBloc: context.read<PaymentBloc>(),
                )),
        BlocProvider(
            create: (_) => CategoryBloc(categoryRepo: CategoryRepo())
              ..add(LoadCategories())),
        BlocProvider(
            create: (_) => ProductBloc(
                  productRepo: ProductRepo(),
                )..add(LoadProducts())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

import 'package:delivery_app/blocs/auth/auth_bloc.dart';
import 'package:delivery_app/blocs/cart/cart_bloc.dart';
import 'package:delivery_app/blocs/category/category_bloc.dart';
import 'package:delivery_app/blocs/checkout/checkout_bloc.dart';
import 'package:delivery_app/blocs/payment/payment_bloc.dart';
import 'package:delivery_app/blocs/product/product_bloc.dart';
import 'package:delivery_app/blocs/user/user_bloc.dart';
import 'package:delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:delivery_app/config/app_router.dart';
import 'package:delivery_app/config/theme.dart';
import 'package:delivery_app/models/models.dart';
import 'package:delivery_app/repositories/auth/auth_repo.dart';
import 'package:delivery_app/repositories/category/category_repo.dart';
import 'package:delivery_app/repositories/checkout/checkout_repo.dart';
import 'package:delivery_app/repositories/local_storage/local_storage_repo.dart';
import 'package:delivery_app/repositories/product/product_repo.dart';
import 'package:delivery_app/repositories/user/user_repo.dart';
import 'package:delivery_app/screens/screens.dart';
import 'package:delivery_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => UserRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepo: context.read<AuthRepo>(),
                  userRepo: context.read<UserRepo>())),
          BlocProvider(
              create: (context) =>
                  UserBloc(userRepo: context.read<UserRepo>())),
          BlocProvider(
              create: (_) => WishlistBloc(localStorageRepo: LocalStorageRepo())
                ..add(StartWishList())),
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
      ),
    );
  }
}

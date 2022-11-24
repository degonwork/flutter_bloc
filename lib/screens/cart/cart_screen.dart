import 'package:delivery_app/blocs/cart/cart_bloc.dart';
import 'package:delivery_app/screens/screens.dart';
import 'package:delivery_app/widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/cart_product_card.dart';
import '../../widgets/custom_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName = '/cart';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: "Cart"),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, CheckOutScreen.routeName);
                  },
                  child: Text(
                    "GO TO CHECK OUT",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
              ],
            ),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.cart.deliveryFeeString,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const RoundedRectangleBorder(),
                                      elevation: 0),
                                  onPressed: () {},
                                  child: Text(
                                    "Add More Items",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                itemCount: state.cart
                                    .productQuantity(state.cart.products)
                                    .keys
                                    .length,
                                itemBuilder: (context, index) =>
                                    CartProducrCard(
                                        quantity: state.cart
                                            .productQuantity(
                                                state.cart.products)
                                            .values
                                            .elementAt(index),
                                        product:
                                            state.cart
                                                .productQuantity(
                                                    state.cart.products)
                                                .keys
                                                .elementAt(index)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const OrderSummary(),
                  ],
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ));
  }
}

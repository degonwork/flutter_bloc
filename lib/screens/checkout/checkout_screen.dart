import 'package:delivery_app/screens/order/order_comfirmation.dart';
import 'package:delivery_app/screens/payment/payment_selection.dart';
import 'package:delivery_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/checkout/checkout_bloc.dart';
import '../../models/payment_method_model.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);
  static const String routeName = '/checkout';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CheckOutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Checkout",
        action: Container(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CheckoutLoaded) {
                    switch (state.paymentMethod) {
                      case PaymentMethod.app_pay:
                        return Text(
                          "Pay with Apple",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        );

                      case PaymentMethod.google_pay:
                        return Text(
                          "Pay with goole",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        );
                    }
                  } else {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CUSTOMER INFORMATION',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(email: value),
                          );
                    }, context, "Email"),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(fullName: value),
                          );
                    }, context, "Full Name"),
                    const SizedBox(height: 30),
                    Text(
                      'DELIVERY INFORMATION',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(address: value),
                          );
                    }, context, "Address"),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(city: value),
                          );
                    }, context, "City"),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(country: value),
                          );
                    }, context, "Country"),
                    _buildTextFormField((value) {
                      context.read<CheckoutBloc>().add(
                            UpdateCheckout(zipCode: value),
                          );
                    }, context, "Zip Code"),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PaymentSelectionScreen.routeName);
                              },
                              child: Text(
                                "SELECT A PAYMENT METHOD",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const OrderSummary(),
                  ],
                ),
              );
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              labelText,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
              child: TextFormField(
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

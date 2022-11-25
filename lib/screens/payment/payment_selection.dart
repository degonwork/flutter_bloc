import 'package:delivery_app/models/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../blocs/payment/payment_bloc.dart';
import '../../widgets/custom_appbar.dart';

class PaymentSelectionScreen extends StatelessWidget {
  const PaymentSelectionScreen({super.key});
  static const String routeName = '/payment_selection';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const PaymentSelectionScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Payment Selection",
        action: Container(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {},
                child: Text(
                  "ORDER NOW",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.black,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                            const SelectPaymentMethod(
                                paymentMethod: PaymentMethod.app_pay));
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Pay with Apple",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.black,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        context.read<PaymentBloc>().add(
                            const SelectPaymentMethod(
                                paymentMethod: PaymentMethod.google_pay));
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Pay with Google",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}

import 'package:delivery_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppbar(title: "Checkout"),
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
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CUSTOMER INFORMATION',
              style: Theme.of(context).textTheme.headline3,
            ),
            _buildTextFormField(emailController, context, "Email"),
            _buildTextFormField(nameController, context, "Full Name"),
            Text(
              'DELIVERY INFORMATION',
              style: Theme.of(context).textTheme.headline3,
            ),
            _buildTextFormField(addressController, context, "Address"),
            _buildTextFormField(cityController, context, "City"),
            _buildTextFormField(countryController, context, "Country"),
            _buildTextFormField(zipCodeController, context, "Zip Code"),
            Text(
              'ORDER SUMMARY',
              style: Theme.of(context).textTheme.headline3,
            ),
            const OrderSummary(),
          ],
        ),
      ),
    );
  }

  Padding _buildTextFormField(TextEditingController controller,
      BuildContext context, String labelText) {
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
            controller: controller,
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

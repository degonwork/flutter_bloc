import 'package:delivery_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key, required this.category}) : super(key: key);
  final Category category;
  static const String routeName = '/catalog';
  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where(
          (product) => product.category == category.name,
        )
        .toList();
    return Scaffold(
      appBar: CustomAppbar(title: category.name),
      bottomNavigationBar: const CustomNavBar(),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.15),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) => Center(
          child: ProductCard(
            product: categoryProducts[index],
            widthFactor: 2.2,
          ),
        ),
      ),
    );
  }
}

import 'package:delivery_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ProductCard(
              product: products[index],
            ),
          ),
        ),
      ),
    );
  }
}

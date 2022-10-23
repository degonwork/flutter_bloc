import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app/models/category_model.dart';
import 'package:delivery_app/models/models.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/hero_carousel_card.dart';
import '../../widgets/product_carousel.dart';
import '../../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Zero To unicorn"),
      bottomNavigationBar: const CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: Category.categories
                  .map((category) => HeroCarouselCard(category: category))
                  .toList(),
            ),
            const SectionTitle(
              title: "RECOMMENDED",
            ),
            ProductCarousel(
              products: Product.products
                  .where((product) => product.isRecommended)
                  .toList(),
            ),
            const SectionTitle(
              title: "MOST POPULAR",
            ),
            ProductCarousel(
              products: Product.products
                  .where((product) => product.isPopular)
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

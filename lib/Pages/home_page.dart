import 'package:flutter/material.dart';
import 'package:resqfood/Widgets/banner_carousel.dart';
import 'package:resqfood/Widgets/navbar.dart';
import 'package:resqfood/Widgets/product_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
            BannerCarousel(),
            ProductCarousel(label: 'Near Me',),
            ProductCarousel(label: 'Recommended',),
            ProductCarousel(label: 'Promo',),
          ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
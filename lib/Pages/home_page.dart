import 'package:flutter/material.dart';
import 'package:resqfood/Components/navbar.dart';
import 'package:resqfood/Components/product_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
            ProductCarousel(label: 'Near Me',),
            ProductCarousel(label: 'Recommended',),
            ProductCarousel(label: 'Promo',),
          ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
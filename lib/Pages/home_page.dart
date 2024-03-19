import 'package:flutter/material.dart';
import 'package:resqfood/widgets/banner_carousel.dart';
import 'package:resqfood/widgets/navbar.dart';
import 'package:resqfood/widgets/vendor_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
            BannerCarousel(),
            VendorCarousel(label: 'Near Me',),
            VendorCarousel(label: 'Recommended',),
            VendorCarousel(label: 'Promo',),
          ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
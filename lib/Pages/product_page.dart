import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';

class ProductPage extends StatelessWidget {
  final Restaurant restaurant;
  const ProductPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name),),
      body: restaurant.profileImage == null? null : Hero(tag: restaurant, child: Image(image: restaurant.profileImage!)),
    );
  }
}
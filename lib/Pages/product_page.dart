import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/Widgets/product_header.dart';

class ProductPage extends StatelessWidget {
  final Restaurant restaurant;
  const ProductPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name),),
      body: AspectRatio(aspectRatio: 16/8, child: ProductHeader(restaurant: restaurant,))
    );
  }
}
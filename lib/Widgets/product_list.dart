import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/Widgets/product_collection.dart';

class ProductList extends ProductCollection {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Restaurant>>? query;

  @override
  void initState() {
    query = widget.getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
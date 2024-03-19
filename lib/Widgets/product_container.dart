import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/Pages/product_page.dart';
import 'package:resqfood/Widgets/product_header.dart';

class ProductContainer extends StatelessWidget {
  final Restaurant restaurant;
  const ProductContainer({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/10,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: const Border.fromBorderSide(BorderSide(color: Colors.grey, width: 1, strokeAlign: BorderSide.strokeAlignOutside)),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductPage(restaurant: restaurant)
                )
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: ProductHeader(restaurant: restaurant),
                ),
                Expanded(
                  flex: 4,
                  child: Ink(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(restaurant.category, style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text(restaurant.openTimeDesc, style: const TextStyle(fontSize: 10),),
                            ],
                          ),
                          Text(restaurant.finalPriceAsString, style: const TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
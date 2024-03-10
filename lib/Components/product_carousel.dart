import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resqfood/Components/product_container.dart';

class ProductCarousel extends StatelessWidget {
  final String label;
  const ProductCarousel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widthFraction = 0.85;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * (1 - widthFraction) * 0.5),
            child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.only(
                    left: screenWidth * (1 - widthFraction) * (index==0?0.5:0.25),
                    top: 1,
                    bottom: 1,
                  ),
                  width: screenWidth * widthFraction,
                  child: const ProductContainer(),
                )
              )
              .followedBy([
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){}, child: const Icon(Icons.arrow_forward_ios_rounded)),
                      const Text("See More")
                    ],
                  ),
                )
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }
}
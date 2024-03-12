import 'package:flutter/material.dart';
import 'package:resqfood/Widgets/product_container.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

const int lengthLimit = 5;

class ProductCarousel extends StatefulWidget {
  final String label;
  const ProductCarousel({super.key, required this.label});

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final query = supabase.from('restaurants').select('*, restaurant_categories(name)').order('id', ascending: true).limit(lengthLimit);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double widthFraction = 0.85;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * (1 - widthFraction) * 0.5),
            child: Text(widget.label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: query,
              builder: (context, snapshot) {
                List<Widget>? products;
                if(!snapshot.hasData){
                  products = List<Widget>.generate(
                    5,
                    (index) => Container(
                      margin: EdgeInsets.only(
                        left: screenWidth * (1 - widthFraction) * (index==0?0.5:0.25),
                        top: 1,
                        bottom: 1,
                      ),
                      width: screenWidth * widthFraction,
                      child: Skeletonizer(
                        enabled: true,
                        child: ProductContainer(restaurant: Restaurant.fake,)
                      ),
                    )
                  );
                }
                else{
                  products = List<Widget>.generate(
                    snapshot.data!.length,
                    (index) => Container(
                      margin: EdgeInsets.only(
                        left: screenWidth * (1 - widthFraction) * (index==0?0.5:0.25),
                        top: 1,
                        bottom: 1,
                      ),
                      width: screenWidth * widthFraction,
                      child: ProductContainer(restaurant: Restaurant.fromMap(snapshot.data![index])),
                    )
                  );
                }
                return Row(
                  children: products
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
                  ]).toList()
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
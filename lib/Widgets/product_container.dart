import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/Pages/product_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductContainer extends StatelessWidget {
  final Restaurant restaurant;
  const ProductContainer({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductPage(restaurant: restaurant)
          )
        );
      },
      child: AspectRatio(
        aspectRatio: 16/10,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: const Border.fromBorderSide(BorderSide(color: Colors.grey, width: 1, strokeAlign: BorderSide.strokeAlignOutside)),
            color: Colors.grey.shade300
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      clipBehavior: Clip.hardEdge,
                      fit: BoxFit.cover,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                        child: restaurant.backgroundImage != null ? Image(image: restaurant.backgroundImage!,) : null
                      ),
                    ),
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Skeleton.ignore(
                        child: Icon(Icons.favorite_border, color: Colors.white, size: 30, )
                      )
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Wrap(
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Skeleton.leaf(
                            child: Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(1000))
                              ),
                              child: restaurant.profileImage == null ? null :
                                Hero(
                                  tag: restaurant,
                                  child: Image(
                                    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                      if(frame == null){
                                        return const Skeletonizer(child: Bone());
                                      }
                                      return child;
                                    },
                                    image: restaurant.profileImage!
                                  ),
                                ),
                            ),
                          ),
                          Text(
                            restaurant.name,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: ColoredBox(
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
                              Text(restaurant.category ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
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
    );
  }
}
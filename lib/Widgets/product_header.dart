import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/Widgets/favorite_button.dart';
import 'package:resqfood/Widgets/skeletonized_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: restaurant,
      child: ColoredBox(
        color: Colors.grey.shade400,
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
            Positioned(
              top: 0,
              right: 0,
              child: Skeleton.ignore(
                child: FavoriteButton(restaurant: restaurant,),
              ),
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
                        Image(
                          frameBuilder: skeletonizedImageFrameBuilder,
                          image: restaurant.profileImage!
                        ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
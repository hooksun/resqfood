import 'package:flutter/material.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:resqfood/widgets/favorite_button.dart';
import 'package:resqfood/widgets/skeletonized_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VendorHeader extends StatelessWidget {
  const VendorHeader({
    super.key,
    required this.vendor,
  });

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: vendor,
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
                child: vendor.backgroundImage != null ? Image(image: vendor.backgroundImage!,) : null
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Skeleton.ignore(
                child: FavoriteButton(vendor: vendor,),
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
                      child: vendor.profileImage == null ? null :
                        Image(
                          frameBuilder: skeletonizedImageFrameBuilder,
                          image: vendor.profileImage!
                        ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      vendor.name,
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
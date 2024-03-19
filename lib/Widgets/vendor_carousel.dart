import 'package:flutter/material.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:resqfood/widgets/vendor_collection.dart';
import 'package:resqfood/widgets/vendor_container.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const int lengthLimit = 5;

class VendorCarousel extends VendorCollection {
  final String label;
  const VendorCarousel({super.key, required this.label});

  @override
  PostgrestTransformBuilder<List<Map<String, dynamic>>> modifyQuery(PostgrestTransformBuilder<List<Map<String, dynamic>>> q){
    return q.limit(lengthLimit);
  }

  @override
  State<VendorCarousel> createState() => _VendorCarouselState();
}

class _VendorCarouselState extends State<VendorCarousel> {
  Future<List<Vendor>>? query;

  @override
  void initState() {
    query = widget.getItems();
    super.initState();
  }

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
            child: FutureBuilder<List<Vendor>>(
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
                        child: VendorContainer(vendor: Vendor.fake,)
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
                      child: VendorContainer(vendor: snapshot.data![index]),
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
                          Ink(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadiusDirectional.circular(1000)
                            ),
                            child: IconButton(
                              iconSize: 30,
                              onPressed: (){},
                              icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
                            ),
                          ),
                          const Text("See More", style: TextStyle(fontWeight: FontWeight.bold),)
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
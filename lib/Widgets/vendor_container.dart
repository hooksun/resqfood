import 'package:flutter/material.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:resqfood/pages/vendor_page.dart';
import 'package:resqfood/widgets/vendor_header.dart';

class VendorContainer extends StatelessWidget {
  final Vendor vendor;
  const VendorContainer({super.key, required this.vendor});

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
                  builder: (_) => VendorPage(vendor: vendor)
                )
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: VendorHeader(vendor: vendor),
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
                              Text(vendor.category, style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text(vendor.openTimeDesc, style: const TextStyle(fontSize: 10),),
                            ],
                          ),
                          Text(vendor.finalPriceAsString, style: const TextStyle(fontWeight: FontWeight.bold),)
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
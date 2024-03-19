import 'package:flutter/material.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:resqfood/widgets/vendor_header.dart';

class VendorPage extends StatelessWidget {
  final Vendor vendor;
  const VendorPage({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vendor.name),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(aspectRatio: 16/8, child: VendorHeader(vendor: vendor,)),
          Text(vendor.category),

        ],
      )
    );
  }
}
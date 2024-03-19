import 'package:flutter/material.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:resqfood/widgets/vendor_collection.dart';

class VendorList extends VendorCollection {
  const VendorList({super.key});

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  Future<List<Vendor>>? query;

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
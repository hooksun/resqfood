import 'package:flutter/material.dart';
import 'package:resqfood/main.dart';
import 'package:resqfood/objects/vendor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VendorCollection extends StatefulWidget {
  const VendorCollection({super.key});

  Future<List<Vendor>> getItems() async{
    List<Map<String, dynamic>> data = await modifyQuery(supabase
    .from('vendors')
    .select(('*, vendor_categories(name)'))
    .order('id', ascending: true));
    return data.map((e) => Vendor.fromMap(e)).toList();
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>> modifyQuery(PostgrestTransformBuilder<List<Map<String, dynamic>>> q){
    return q;
  }
}
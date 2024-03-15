import 'package:flutter/material.dart';
import 'package:resqfood/Objects/retaurant.dart';
import 'package:resqfood/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductCollection extends StatefulWidget {
  const ProductCollection({super.key});

  Future<List<Restaurant>> getItems() async{
    List<Map<String, dynamic>> data = await modifyQuery(supabase
    .from('restaurants')
    .select(('*, restaurant_categories(name)'))
    .order('id', ascending: true));
    return data.map((e) => Restaurant.fromMap(e)).toList();
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>> modifyQuery(PostgrestTransformBuilder<List<Map<String, dynamic>>> q){
    return q;
  }
}
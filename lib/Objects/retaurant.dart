import 'package:flutter/material.dart';
import 'package:resqfood/Objects/supabase_image_provider.dart';

class Restaurant {
  int id;
  String name;
  String? category;
  String? openTime;
  String? closeTime;
  double productPrice;
  double productDiscount;
  String? desc;
  String? profileImagePath;
  String? backgroundImagePath;
  ImageProvider? profileImage;
  ImageProvider? backgroundImage;

  Restaurant(this.id,
  {
    required this.name,
    this.category,
    this.openTime,
    this.closeTime,
    this.productPrice = 0,
    this.productDiscount = 0,
    this.desc,
    this.profileImagePath,
    this.backgroundImagePath,
    this.profileImage,
    this.backgroundImage,
  });

  static Restaurant fromMap(Map<String, dynamic> map){
    String? profileImagePath = map['profile_image_path'];
    String? backgroundImagePath = map['background_image_path'];
    return Restaurant(
      map['id'],
      name: map['name'],
      category: map['restaurant_categories']['name'],
      openTime: map['open_time'].toString().substring(0, 5),
      closeTime: map['close_time'].toString().substring(0, 5),
      productPrice: (map['product_price'] ?? 0).toDouble(),
      productDiscount: (map['product_discount'] ?? 0).toDouble(),
      desc: map['desc'],
      profileImagePath: profileImagePath,
      backgroundImagePath: backgroundImagePath,
      profileImage: profileImagePath != null ? SupabaseImageProvider(path: profileImagePath) : null, //TODO: Change to default image
      backgroundImage: backgroundImagePath != null ? SupabaseImageProvider(path: backgroundImagePath): null,
    );
  }

  static Restaurant get fake => Restaurant(
    0,
    name: 'Starbucks Coffee',
    category: 'Coffee & Pastry',
    openTime: '00:00',
    closeTime: '00:00',
    productPrice: 10000,
    productDiscount: 0,
    desc: '',
  );

  int get finalPrice => (productPrice * (100 - productDiscount) * 0.01).toInt();

  String get openTimeDesc => "Open at: $openTime - $closeTime";

  String get finalPriceAsString => "Rp. $finalPrice";

  // Future<Uint8List?> get profileImageFuture{
  //   if(_profileImageFuture != null){
  //     return _profileImageFuture!;
  //   }
  //   if(profileImagePath == null){
  //     return Future.value(null);
  //   }
  //   return supabase.storage.from('test').download(profileImagePath!);
  // }
}
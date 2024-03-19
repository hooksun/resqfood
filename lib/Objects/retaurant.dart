import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resqfood/Objects/supabase_image_provider.dart';
import 'package:resqfood/main.dart';

class Restaurant {
  int id;
  String name;
  String category;
  String openTime;
  String closeTime;
  double productPrice;
  double productDiscount;
  String desc;
  String? profileImagePath;
  String? backgroundImagePath;
  ImageProvider? profileImage;
  ImageProvider? backgroundImage;

  bool? favorited;

  Restaurant(this.id,
  {
    required this.name,
    this.category = '',
    this.openTime = '00:00',
    this.closeTime = '00:00',
    this.productPrice = 0,
    this.productDiscount = 0,
    this.desc = '',
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
      profileImage: profileImagePath != null ?
        SupabaseImageProvider(path: profileImagePath)
        :
        const AssetImage('assets/images/default_profile.png') as ImageProvider,
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

  static Future<Restaurant> fromID(int id) async{
    return Restaurant.fromMap(await supabase.from('restaurants').select('*').eq('id', id).single());
  }

  Future<bool> getFavoriteByUser({required String userID}) async{
    if(favorited != null){
      return SynchronousFuture(favorited!);
    }
    await updateFavoriteByUser(userID: userID);
    return favorited!;
  }

  Future<void> updateFavoriteByUser({required String userID}) async{
    final data = await supabase.from('user_favorites').select().eq('user_id', userID).eq('restaurant_id', id);
    favorited = data.isNotEmpty;
  }

  Future<void> setFavoriteByUser({required String userID, required bool favorite}) async{
    if(favorite){
      await supabase.from('user_favorites').upsert({'user_id': userID, 'restaurant_id': id});
    }
    else{
      await supabase.from('user_favorites').delete().eq('user_id', userID).eq('restaurant_id', id);
    }
    favorited = favorite;
  }

  int get finalPrice => (productPrice * (100 - productDiscount) * 0.01).toInt();

  String get openTimeDesc => "Open at: $openTime - $closeTime";

  String get finalPriceAsString => "Rp. $finalPrice";
}

Map<int, Listenable> userFavorites = Map.identity();
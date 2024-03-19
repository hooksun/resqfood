import 'package:flutter/material.dart';
import 'package:resqfood/main.dart';
import 'package:resqfood/objects/vendor.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.vendor,});

  final Vendor vendor;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool? favorited;

  @override
  void initState() {
    super.initState();
    if(supabase.auth.currentUser == null){
      return;
    }
    favorited = widget.vendor.favorited;
    () async{
      bool fav = await widget.vendor.getFavoriteByUser(userID: supabase.auth.currentUser!.id);
      if(!mounted){
        return;
      }
      setState(() {
        favorited = fav;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return favorited == null ? const SizedBox.shrink() : IconButton(
      iconSize: 30,
      onPressed: () {
        setState(() {
          favorited = !favorited!;
          if(supabase.auth.currentUser != null){
            widget.vendor.setFavoriteByUser(userID: supabase.auth.currentUser!.id, favorite: favorited!);
          }
        });
      },
      icon: Stack(
        children: [
          const Icon(Icons.favorite_border, color: Colors.white),
          AnimatedScale(
            curve: favorited! ? Curves.elasticOut : Curves.elasticIn,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            scale: favorited! ? 1 : 0,
            child: const Icon(Icons.favorite, color: Colors.red)
          ),
        ]
      ),
    );
  }
}
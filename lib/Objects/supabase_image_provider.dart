import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resqfood/main.dart';

class SupabaseImageProvider extends ImageProvider<SupabaseImageAddress> {
  final String bucket, path;
  const SupabaseImageProvider({required this.path, this.bucket = 'test'});

  @override
  Future<SupabaseImageAddress> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(SupabaseImageAddress(bucket, path));
  }

  @override
  ImageStreamCompleter loadImage(SupabaseImageAddress key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(getImageInfo(key));
  }

  Future<ImageInfo> getImageInfo(SupabaseImageAddress address) async{
    return ImageInfo(image: await decodeImageFromList(await supabase.storage.from(address.bucket).download(address.path)));
  }
}

class SupabaseImageAddress{
  String bucket;
  String path;
  SupabaseImageAddress(this.bucket, this.path);

  @override
  int get hashCode => bucket.hashCode + path.hashCode;

  @override
  bool operator ==(Object other){
    if(other.runtimeType != runtimeType || other is! SupabaseImageAddress){
      return false;
    }
    return (bucket == other.bucket && path == other.path);
  }
}
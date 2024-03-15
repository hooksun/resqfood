import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget skeletonizedImageFrameBuilder(context, child, frame, wasSynchronouslyLoaded) {
  if(frame == null){
    return const Skeletonizer(child: Bone());
  }
  return child;
}
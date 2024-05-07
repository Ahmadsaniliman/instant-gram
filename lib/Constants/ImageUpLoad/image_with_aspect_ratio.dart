import 'package:flutter/material.dart';

@immutable
class ImageWithAspectRatio {
  final Image image;
  final dynamic aspectRatio;

  const ImageWithAspectRatio({
    required this.aspectRatio,
    required this.image,
  });
}

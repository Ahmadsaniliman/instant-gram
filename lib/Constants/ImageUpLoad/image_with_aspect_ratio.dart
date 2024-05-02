import 'package:flutter/material.dart';

@immutable
class ImageWithAspectRatio {
  final Image image;
  final dynamic aspectRatio;

  const ImageWithAspectRatio({
    required this.image,
    required this.aspectRatio,
  });
}

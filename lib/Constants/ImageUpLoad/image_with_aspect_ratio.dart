import 'package:flutter/material.dart';

@immutable
class ImageWithAspectRation {
  final Image image;
  final dynamic ratio;

  const ImageWithAspectRation({
    required this.image,
    required this.ratio,
  });
}

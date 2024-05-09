import 'package:flutter/widgets.dart';

@immutable
class ImageWIthAspectRatio {
  final Image image;
  final dynamic aspectRatio;

  const ImageWIthAspectRatio({
    required this.image,
    required this.aspectRatio,
  });
}

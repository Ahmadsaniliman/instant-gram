import 'dart:async';

import 'package:flutter/material.dart' as material show Image;
import 'package:flutter/rendering.dart';

extension GetImageAspectRation on material.Image {
  Future<dynamic> getAspectRatio() async {
    final completer = Completer();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.height / imageInfo.image.width;
          completer.complete(aspectRatio);
        },
      ),
    );
  }
}

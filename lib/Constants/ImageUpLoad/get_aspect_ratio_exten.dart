import 'dart:async';

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageWithAspectRatio on material.Image {
  Future<dynamic> getAspectratio() async {
    final completer = Completer();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}

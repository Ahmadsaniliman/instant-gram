import 'dart:async';
import 'package:flutter/material.dart' as material;

extension GetAspectRatio on material.Image {
  Future<Future> getImageAspectRaio() async {
    final completer = Completer();
    image
        .resolve(
      const material.ImageConfiguration(),
    )
        .addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          completer.complete(aspectRatio);
        },
      ),
    );

    return completer.future;
  }
}

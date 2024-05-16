import 'dart:typed_data';

import 'package:flutter/material.dart' as material;
import 'package:instantgram/Constants/ImageUpLoad/get_aspect_ratio_exten.dart';

extension GetImageDataAspectRatio on Uint8List {
  Future getImageDataAspectRatio() {
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}

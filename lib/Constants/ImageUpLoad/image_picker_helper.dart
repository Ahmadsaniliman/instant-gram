import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instantgram/Constants/ImageUpLoad/to_file_extension.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePick = ImagePicker();
  static Future<File?> pickImageFromGallery() =>
      _imagePick.pickImage(source: ImageSource.gallery).toFile();
  static Future<File?> pickVideoFromGallery() =>
      _imagePick.pickVideo(source: ImageSource.gallery).toFile();
}

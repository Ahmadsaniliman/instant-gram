import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image/image.dart' as img;
import 'package:instantgram/Constants/ImageUpLoad/get_image_data_aspect_ratio.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUpLoader extends StateNotifier<bool> {
  ImageUpLoader() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upLoad({
    required UserId userId,
    required File file,
    required FileType filetype,
    required Map<PostSettings, bool> postSettings,
  }) async {
    isLoading = true; // or
    state = true;

    late Uint8List thumbnailUint8List;

    switch (filetype) {
      case FileType.video:
        final thumb = VideoThumbnail.thumbnailData(
          video: file.path,
          quality: 75,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 250,
        );
        thumbnailUint8List = thumb as Uint8List;

      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          state = false;
          return false;
        }

        final thumbnail = img.copyResize(
          fileAsImage,
          width: 200,
        );

        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
    }

    final aspectRatio = await thumbnailUint8List.getImageDataAspectRatio();
    final fileName = const Uuid().v4();
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/exception.dart';
import 'package:instantgram/Constants/ImageUpLoad/get_aspect_ratio_exten.dart';
import 'package:instantgram/Constants/ImageUpLoad/image_with_aspect_ratio.dart';
import 'package:instantgram/Constants/ImageUpLoad/thumbnail_request.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (
    ref,
    ThumbnailRequest request,
  ) async {
    final Image image;

    switch (request.fileType) {
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: request.file.path,
          quality: 75,
          imageFormat: ImageFormat.JPEG,
        );

        if (thumb == null) {
          throw const CouldNotBuildThumbnailException();
        }

        image = Image.memory(
          thumb,
          fit: BoxFit.fitHeight,
        );
        break;
      case FileType.image:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );
        break;
    }

    final aspectRatio = await image.getImageAspectRaio();
    return ImageWithAspectRatio(
      image: image,
      aspectRatio: aspectRatio,
    );
  },
);

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:instantgram/Constants/ImageUpLoad/collection_name_file_type.dart';
import 'package:instantgram/Constants/ImageUpLoad/get_image_data_aspect_ratio.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post_pay_load.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUpLoadNotifier extends StateNotifier<bool> {
  ImageUpLoadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upLoad({
    required UserId userId,
    required String message,
    required File file,
    required FileType fileType,
    required Map<PostSettings, bool> postSettings,
  }) async {
    late Uint8List thumbnailUint8List;

    switch (fileType) {
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
          return false;
        }

        final thumbnail = img.copyResize(
          fileAsImage,
          width: 200,
        );

        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
    }

    final fileName = const Uuid().v4();
    final thumbnailAspectRatio =
        await thumbnailUint8List.getImageDataAspectRatio();

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(CollectionNames.thambnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      final thumbnailUpLoadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUpLoadTask.ref.name;

      final originalFileUpLoad = await originalFileRef.putFile(file);
      final originalStorageId = originalFileUpLoad.ref.name;

      final postPayLoad = PostPayLoad(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalStorageId,
        postSettings: postSettings,
      );

      FirebaseFirestore.instance
          .collection(CollectionNames.posts)
          .add(postPayLoad);
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }

    return true;
  }
}

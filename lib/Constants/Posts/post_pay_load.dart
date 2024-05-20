import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post_keys.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

class PostPayLoad extends MapView<String, dynamic> {
  PostPayLoad({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required dynamic aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSettings, bool> postSettings,
  }) : super(
          {
            PostKey.userId: userId,
            PostKey.message: message,
            PostKey.createAt: FieldValue.serverTimestamp(),
            PostKey.thumbnailUrl: thumbnailUrl,
            PostKey.fileUrl: fileUrl,
            PostKey.fileType: fileType,
            PostKey.fileName: fileName,
            PostKey.aspectRatio: aspectRatio,
            PostKey.thumbnalStorageId: thumbnailStorageId,
            PostKey.originalFileStorageId: originalFileStorageId,
            PostKey.postSettings: {
              for (final postSetting in postSettings.entries)
                postSetting.key.storageKey: postSettings.values,
            }
          },
        );
}

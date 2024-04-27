import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post_keys.dart';
import 'package:instantgram/Constants/Posts/post_settings.dart';

@immutable
class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final Map<PostSettings, bool> postSettings;
  final String thumbnalStorageId;
  final String originalFileStorageId;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createAt = (json[PostKey.createAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[PostKey.fileName],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnalStorageId = json[PostKey.thumbnalStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId],
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSettings.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value,
        };

  bool get allowLikes => postSettings[PostSettings.allowLike] ?? false;
  bool get allowComments => postSettings[PostSettings.allowComments] ?? false;
}

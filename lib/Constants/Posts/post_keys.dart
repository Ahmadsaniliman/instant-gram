import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostKey {
  static const userId = 'user_id';
  static const message = 'message';
  static const createAt = 'create_at';
  static const thumbnailUrl = 'thumbnail_url';
  static const fileUrl = 'file_url';
  static const fileType = 'file_type';
  static const fileName = 'file_name';
  static const aspectRatio = 'aspect_ratio';
  static const postSettings = 'post_settings';
  static const thumbnalStorageId = 'thumbnail_storage_id';
  static const originalFileStorageId = 'original_file_storage_id';
}

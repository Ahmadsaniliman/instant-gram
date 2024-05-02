import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';

@immutable
class ThumbnailRequest {
  final File file;
  final FileType fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });
}

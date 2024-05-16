import 'package:instantgram/Constants/Posts/file_type.dart';

extension CollectioName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.video:
        return 'videos';
      case FileType.image:
        return 'image';
    }
  }
}

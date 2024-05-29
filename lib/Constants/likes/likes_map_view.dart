import 'dart:collection';

import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

class LikeMapView extends MapView<String, dynamic> {
  LikeMapView({
    required PostId postId,
    required UserId likedBy,
    required DateTime dateAndTime,
  }) : super(
          {
            FirebaseFieldNames.postId: postId,
            FirebaseFieldNames.userId: likedBy,
            FirebaseFieldNames.date: dateAndTime,
          },
        );
}

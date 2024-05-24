import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

@immutable
class CommentPayLoad extends MapView<String, dynamic> {
  CommentPayLoad({
    required UserId userId,
    required String comment,
    required PostId postId,
  }) : super(
          {
            FirebaseFieldNames.comment: comment,
            FirebaseFieldNames.userId: userId,
            FirebaseFieldNames.postId: postId,
            FirebaseFieldNames.createdAt: FieldValue.serverTimestamp(),
          },
        );
}

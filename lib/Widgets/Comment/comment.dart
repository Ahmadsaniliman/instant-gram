import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Widgets/Comment/comment_id.dart';

@immutable
class Comment {
  final CommentId commentId;
  final PostId postId;
  final String comment;
  final DateTime createdAt;
  final UserId userId;

  Comment(Map<String, dynamic> json, {required this.commentId})
      : comment = json[FirebaseFieldNames.comment],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        postId = json[FirebaseFieldNames.postId],
        userId = json[FirebaseFieldNames.userId];

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          comment == other.comment &&
          postId == other.postId &&
          createdAt == other.createdAt &&
          commentId == other.commentId &&
          userId == other.userId;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          commentId,
          commentId,
          postId,
          userId,
          createdAt,
        ],
      );
}

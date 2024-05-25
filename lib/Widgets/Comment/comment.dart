import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Widgets/Comment/comment_id.dart';

@immutable
class Comment {
  final CommentId id;
  final UserId userId;
  final PostId postId;
  final String message;
  final DateTime createdAt;

  Comment(Map<String, dynamic> json, {required this.id})
      : userId = json[FirebaseFieldNames.userId],
        postId = json[FirebaseFieldNames.postId],
        createdAt = json[FirebaseFieldNames.createdAt],
        message = json[FirebaseFieldNames.comment];

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          postId == other.postId &&
          createdAt == other.createdAt &&
          message == other.message;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          message,
          userId,
          postId,
          createdAt,
        ],
      );
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';

@immutable
class PostWithComment {
  final Post post;
  final Iterable<Comment> comment;

  const PostWithComment({
    required this.post,
    required this.comment,
  });

  @override
  bool operator ==(covariant PostWithComment other) =>
      post == other.post &&
      const IterableEquality().equals(
        comment,
        other.comment,
      );

  @override
  int get hashCode => Object.hashAll(
        [
          post,
          comment,
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/Comment/compact_comment.dart';

class ColumnCompactComment extends StatelessWidget {
  final Iterable<Comment> comments;
  const ColumnCompactComment({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: comments
          .map(
            (
              comment,
            ) =>
                CompactComment(
              comment: comment,
            ),
          )
          .toList(),
    );
  }
}

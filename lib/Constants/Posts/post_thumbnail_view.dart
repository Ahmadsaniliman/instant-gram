import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapp;
  const PostThumbnailView({
    super.key,
    required this.post,
    required this.onTapp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapp,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

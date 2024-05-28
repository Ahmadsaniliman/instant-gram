import 'package:flutter/material.dart';
import 'package:instantgram/Constants/Posts/file_type.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_image_view.dart';

class PostVideoOrImageView extends StatelessWidget {
  final Post post;
  const PostVideoOrImageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.video:
        return PostVideoOrImageView(post: post);
      case FileType.image:
        return PostImageView(post: post);
    }
  }
}

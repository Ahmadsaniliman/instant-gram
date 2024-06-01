import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_with_commentd.dart';

class PostDetails extends ConsumerStatefulWidget {
  final Post post;
  const PostDetails({
    super.key,
    required this.post,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailsState();
}

class _PostDetailsState extends ConsumerState<PostDetails> {
  @override
  Widget build(BuildContext context) {
    // final postWithComments = PostWithComment(post: widget.post, comment: );
    return Container();
  }
}

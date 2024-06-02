import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/delete_post/can_curr_user_delete_post.dart';
import 'package:instantgram/Constants/Posts/delete_post/delete_post_provider.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_image_or_video_view.dart';
import 'package:instantgram/Constants/Posts/post_name_and_message_view.dart';
import 'package:instantgram/Constants/Posts/post_time_and_date_view.dart';
import 'package:instantgram/Constants/Posts/post_with_comments_provider.dart';
import 'package:instantgram/Constants/likes/like_button.dart';
import 'package:instantgram/Constants/likes/likes_count.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/LottieAnimations/small_err_anim_view.dart';
import 'package:instantgram/Widgets/Comment/comment_view.dart';
import 'package:instantgram/Widgets/Comment/request_dor_post_and_comment.dart';
import 'package:share_plus/share_plus.dart';

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
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      sortByCreatedAt: true,
      limit: 3,
      dateSorting: DateSorting.newToOld,
    );

    final postAndComment = ref.watch(postWithCommentProvider(request));

    final canDeletePost = ref.watch(canCurrUserDeletePost(widget.post));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: [
          postAndComment.when(
            data: (data) {
              return IconButton(
                onPressed: () {
                  final url = data.post.fileUrl;
                  Share.share(url);
                },
                icon: const Icon(Icons.share),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return const Center(
                child: Text('Error'),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          if (canDeletePost.value ?? false)
            IconButton(
                onPressed: () {
                  ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                },
                icon: const Icon(Icons.delete)),
        ],
      ),
      body: postAndComment.when(data: (data) {
        final postId = data.post.postId;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PostVideoOrImageView(post: data.post),
              Row(
                children: [
                  if (data.post.allowLikes) LikeButton(postId: postId),
                  if (data.post.allowLikes)
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CommentView(postId: postId),
                          ),
                        );
                      },
                      icon: const Icon(Icons.comment_sharp),
                    ),
                ],
              ),
              PostNameAndMessageView(post: data.post),
              PostDateAndTime(dateTime: data.post.createAt),
              const Divider(color: Colors.white),
              LikesCountView(postId),
            ],
          ),
        );
      }, error: (_, __) {
        return const SmallErrorAnimationView(key: null);
      }, loading: () {
        return const LoadingAnimationView(key: null);
      }),
    );
  }
}

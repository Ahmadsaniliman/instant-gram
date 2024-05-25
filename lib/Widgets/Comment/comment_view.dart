import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instantgram/LottieAnimations/empty_content_anim_view.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';
import 'package:instantgram/Widgets/Comment/comment_provider.dart';
import 'package:instantgram/Widgets/Comment/comment_tile.dart';
import 'package:instantgram/Widgets/Comment/post_comment_provider.dart';
import 'package:instantgram/Widgets/Comment/request_dor_post_and_comment.dart';

class CommentView extends HookConsumerWidget {
  final PostId postId;
  const CommentView({
    super.key,
    required this.postId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(
        postId: postId,
        sortByCreatedAt: true,
        limit: 1,
        dateSorting: DateSorting.newToOld,
      ),
    );

    final comments = ref.watch(
      postCommentProvider(request.value),
    );

    useEffect(
      () {
        commentController.addListener(
          () {
            hasText.value = commentController.text.isNotEmpty;
          },
        );
        return () {};
      },
      [commentController],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coment'),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    await ref.read(sendCommentProvider.notifier).sendComment(
                          userId: userId,
                          postId: postId,
                          comment: commentController.text,
                        );
                    commentController.clear();
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: comments.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentAnimationView(text: 'No Comment here'),
                    );
                  }
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final comment = data.elementAt(index);
                        return CommentTile(comment: comment);
                      },
                    ),
                    onRefresh: () {
                      return ref.refresh(postCommentProvider(request.value)
                          as Refreshable<Future<void>>);
                    },
                  );
                },
                error: (_, __) {
                  return ErrorAnimationView(key: key);
                },
                loading: () {
                  return LoadingAnimationView(key: key);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                        hintText: 'Write your comments here'),
                    onSubmitted: (comment) async {
                      final userId = ref.read(userIdProvider);
                      if (comment.isNotEmpty) {
                        await ref
                            .read(sendCommentProvider.notifier)
                            .sendComment(
                              userId: userId.toString(),
                              postId: postId,
                              comment: comment,
                            );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

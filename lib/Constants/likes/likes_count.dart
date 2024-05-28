import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/likes/likes_provider.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';

class LikesCountView extends ConsumerWidget {
  const LikesCountView({
    super.key,
    required this.postId,
  });

  final PostId postId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesPro = ref.watch(likesProvider(postId));
    return likesPro.when(
      data: (data) {
        final peronsOrPeople = data == 1 ? 'person' : 'people';
        final likeText = '$data $peronsOrPeople likeThisPost';
        return Text(likeText);
      },
      error: (_, __) {
        return ErrorAnimationView(key: key);
      },
      loading: () {
        return LoadingAnimationView(key: key);
      },
    );
  }
}

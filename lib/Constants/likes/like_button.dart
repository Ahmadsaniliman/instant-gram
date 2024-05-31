import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/likes/has_like_post.dart';
import 'package:instantgram/Constants/likes/like_dislike_provider.dart';
import 'package:instantgram/Constants/likes/likes_request.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/LottieAnimations/small_err_anim_view.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({
    super.key,
    required this.postId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haskLike = ref.watch(
      hasLikeProvider(postId),
    );
    return haskLike.when(
      data: (data) {
        return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            final likeRequest = LikesRequest(
              postId: postId,
              likedBy: userId.toString(),
            );

            ref.read(
              likeDisLikeProvider(likeRequest),
            );
          },
          icon: FaIcon(
            data ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          ),
        );
      },
      error: (_, __) {
        return SmallErrorAnimationView(key: key);
      },
      loading: () {
        return LoadingAnimationView(key: key);
      },
    );
  }
}

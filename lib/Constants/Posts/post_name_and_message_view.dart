import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/rich_text.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/Widgets/UserModel/user_model_provider.dart';

class PostNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostNameAndMessageView({
    super.key,
    required this.post,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(
      userModelProvider(post.userId),
    );
    return userModel.when(
      data: (data) {
        return RichTwoTextWidget(
          leftPart: data.displayName,
          rightPart: post.message,
        );
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

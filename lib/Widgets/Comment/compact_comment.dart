import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/rich_text.dart';
import 'package:instantgram/LottieAnimations/small_err_anim_view.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/UserModel/user_model_provider.dart';

class CompactComment extends ConsumerWidget {
  final Comment comment;
  const CompactComment({
    super.key,
    required this.comment,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userModelProvider(comment.postId));
    return userInfo.when(data: (data) {
      return RichTwoTextWidget(
        leftPart: data.displayName,
        rightPart: comment.message,
      );
    }, error: (_, __) {
      return SmallErrorAnimationView(key: key);
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

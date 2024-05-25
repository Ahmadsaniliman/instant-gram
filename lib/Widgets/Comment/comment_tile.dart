import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/UserModel/user_model_provider.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userModelProvider(comment.userId),
    );
    return userInfo.when(
      data: (data) {
        final currUser = ref.read(userIdProvider);
        return ListTile(
          title: Text(data.displayName),
          subtitle: Text(comment.message),
          trailing: currUser == data.userId
              ? IconButton(
                  onPressed: () {
                    // delete comment here
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
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

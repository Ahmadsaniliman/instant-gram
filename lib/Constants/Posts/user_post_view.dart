import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/posts_grid_view.dart';
import 'package:instantgram/LottieAnimations/empty_content_anim_view.dart';
import 'package:instantgram/LottieAnimations/error_anim_view.dart';
import 'package:instantgram/LottieAnimations/oading_anim_view.dart';
import 'package:instantgram/Providers/Provids/user_posts_provider.dart';
import 'package:instantgram/Widgets/Strings/strings.dart';

class UserPostsVie extends ConsumerWidget {
  const UserPostsVie({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(data: (data) {
        if (data.isEmpty) {
          return EmptyContentAnimationView(
            key: key,
            text: Strings.youHaveNoPosts,
          );
        } else {
          return PostsGridView(
            posts: data,
          );
        }
      }, error: (_, __) {
        return ErrorAnimationView(
          key: key,
        );
      }, loading: () {
        return LoadingAnimationView(
          key: key,
        );
      }),
    );
  }
}

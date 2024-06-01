import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

final canCurrUserDeletePost = StreamProvider.family.autoDispose<bool, Post>(
  (
    ref,
    Post post,
  ) async* {
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
);

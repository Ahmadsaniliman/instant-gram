import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Widgets/Comment/delete_comment.notifier.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, bool>(
  (ref) => DeleteCommentNotifier(),
);

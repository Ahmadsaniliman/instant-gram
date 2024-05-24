import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Widgets/Comment/send_comment.dart';

final sendCommentProvider = StateNotifierProvider<SendCommentNotifier, bool>(
  (ref) => SendCommentNotifier(),
);

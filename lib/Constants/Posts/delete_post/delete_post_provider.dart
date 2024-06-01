import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/delete_post/delete_post_notifier.dart';

final deletePostProvider = StateNotifierProvider<DeletePostNotifier, bool>(
  (_) => DeletePostNotifier(),
);

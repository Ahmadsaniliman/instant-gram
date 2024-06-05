import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/post.dart';

final searchPostProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, String>(
  (ref, String searchTerm) {
    final controller = StreamController<Iterable<Post>>();
    ref.onDispose(
      () {
        controller.close();
      },
    );
    return controller.stream;
  },
);

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Post>>();

  controller.onListen = () {
    controller.sink.add(
      [],
    );
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseFieldNames.posts)
      .orderBy(
        FirebaseFieldNames.createdAt,
        descending: true,
      )
      .where(
        FirebaseFieldNames.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen(
    (snapshot) {
      final document = snapshot.docs;
      final posts = document.where((doc) => doc.metadata.hasPendingWrites).map(
            (doc) => Post(
              postId: doc.id,
              json: doc.data(),
            ),
          );

      controller.sink.add(posts);
    },
  );

  ref.onDispose(
    () {
      sub.cancel();
      controller.close();
    },
  );

  return controller.stream;
});

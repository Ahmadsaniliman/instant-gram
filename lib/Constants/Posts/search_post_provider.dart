import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post.dart';

final searchPostProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, String>(
  (ref, String searchTerm) {
    final controller = StreamController<Iterable<Post>>();

    final sub = FirebaseFirestore.instance
        .collection(CollectionNames.posts)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        final post = snapshot.docs
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            )
            .where(
              (post) => post.message.toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  ),
            );
        controller.sink.add(post);
      },
    );
    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );
    return controller.stream;
  },
);

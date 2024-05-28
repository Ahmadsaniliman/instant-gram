import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';

final likesProvider = StreamProvider.family.autoDispose<int, String>(
  (
    ref,
    PostId postId,
  ) {
    final controller = StreamController<int>.broadcast();

    controller.sink.add(0);

    final sub = FirebaseFirestore.instance
        .collection(CollectionNames.likes)
        .where(FirebaseFieldNames.postId, isEqualTo: postId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        controller.sink.add(snapshot.docs.length);
      },
    );

    ref.onDispose(
      () {
        controller.close();
      },
    );

    return controller.stream;
  },
);

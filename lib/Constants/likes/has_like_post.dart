import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Providers/Provids/user_id_provider.dart';

final hasLikeProvider = StreamProvider.family.autoDispose<bool, PostId>(
  (
    ref,
    PostId postId,
  ) {
    final controller = StreamController<bool>();

    final userId = ref.watch(userIdProvider);

    final sub = FirebaseFirestore.instance
        .collection(
          CollectionNames.likes,
        )
        .where(
          FirebaseFieldNames.postId,
          isEqualTo: postId,
        )
        .where(
          FirebaseFieldNames.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          controller.add(false);
        } else {
          controller.add(true);
        }
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

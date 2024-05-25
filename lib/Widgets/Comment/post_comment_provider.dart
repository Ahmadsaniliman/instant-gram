import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/Comment/request_dor_post_and_comment.dart';
import 'package:instantgram/Widgets/Comment/sorting_extension.dart';

final postCommentProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
  (ref, RequestForPostAndComments request) {
    final controller = StreamController<Iterable<Comment>>();

    final sub = FirebaseFirestore.instance
        .collection(CollectionNames.comments)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .snapshots()
        .listen(
      (snapshot) {
        final document = snapshot.docs;
        final limitedDocument =
            request.limit != null ? document.take(request.limit!) : document;
        final comment = limitedDocument
            .where((element) => element.metadata.hasPendingWrites)
            .map(
              (e) => Comment(
                e.data(),
                id: e.id,
              ),
            );

        final result = comment.applySorting(request);
        controller.sink.add(result);
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

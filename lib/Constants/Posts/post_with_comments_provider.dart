import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_with_commentd.dart';
import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/Comment/request_dor_post_and_comment.dart';
import 'package:instantgram/Widgets/Comment/sorting_extension.dart';

final postWithCommentProvider = StreamProvider.family
    .autoDispose<PostWithComment, RequestForPostAndComments>(
  (
    ref,
    RequestForPostAndComments request,
  ) {
    final controller = StreamController<PostWithComment>();

    Post? post;
    Iterable<Comment>? comments;

    void notify() {
      final localPost = post;
      if (localPost == null) {
        return;
      }

      final outPutComment = (comments ?? []).applySorting(request);
      final result = PostWithComment(post: localPost, comment: outPutComment);
      controller.sink.add(result);
    }

    final postSub = FirebaseFirestore.instance
        .collection(CollectionNames.posts)
        .where(FieldPath.documentId, isEqualTo: request.postId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          return;
        }

        final doc = snapshot.docs.first;
        if (doc.metadata.hasPendingWrites) {
          return;
        }
        post = Post(postId: doc.id, json: doc.data());
        notify();
      },
    );

    final commentQuery = FirebaseFirestore.instance
        .collection(CollectionNames.comments)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .orderBy(
          FirebaseFieldNames.createdAt,
          descending: true,
        );

    final limitedComment = request.limit != null
        ? commentQuery.limit(request.limit!)
        : commentQuery;

    final commentSub = commentQuery.snapshots().listen(
      (snapshot) {
        comments =
            snapshot.docs.where((doc) => !doc.metadata.hasPendingWrites).map(
                  (doc) => Comment(doc.data(), id: doc.id),
                );
      },
    );

    ref.onDispose(
      () {
        postSub.cancel();
        controller.close();
      },
    );
    return controller.stream;
  },
);

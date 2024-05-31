import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/likes/likes_map_view.dart';
import 'package:instantgram/Constants/likes/likes_request.dart';

final likeDisLikeProvider =
    FutureProvider.family.autoDispose<bool, LikesRequest>(
  (
    ref,
    LikesRequest request,
  ) async {
    final query = FirebaseFirestore.instance
        .collection(CollectionNames.likes)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .where(FirebaseFieldNames.userId, isEqualTo: request.likedBy)
        .get();

    final hasLike = await query.then(
      (snapshot) {
        return snapshot.docs.isNotEmpty;
      },
    );

    if (hasLike) {
      try {
        await query.then(
          (snapshot) {
            for (final doc in snapshot.docs) {
              doc.reference.delete();
            }
          },
        );
        return true;
      } catch (e) {
        return false;
      }
    } else {
      try {
        final like = LikeMapView(
          postId: request.postId,
          likedBy: request.likedBy,
          dateAndTime: DateTime.now(),
        );

        await FirebaseFirestore.instance
            .collection(CollectionNames.likes)
            .add(like);
        return true;
      } catch (e) {
        return false;
      }
    }
  },
);

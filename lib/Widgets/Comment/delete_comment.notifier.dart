import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Widgets/Comment/comment_id.dart';

class DeleteCommentNotifier extends StateNotifier<bool> {
  DeleteCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deleteComment({
    required CommentId commentId,
  }) async {
    try {
      final query = FirebaseFirestore.instance
          .collection(CollectionNames.comments)
          .where(FieldPath.documentId, isEqualTo: commentId)
          .limit(1)
          .get();

      await query.then(
        (value) async {
          for (final doc in value.docs) {
            await doc.reference.delete();
          }
        },
      );
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

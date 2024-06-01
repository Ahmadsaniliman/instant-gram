import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/ImageUpLoad/collection_name_file_type.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/fibase_fields.dart';
import 'package:instantgram/Constants/Posts/post.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';

class DeletePostNotifier extends StateNotifier<bool> {
  DeletePostNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletePost({required Post post}) async {
    isLoading = true;

    try {
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(CollectionNames.thambnails)
          .child(post.originalFileStorageId)
          .delete();

      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.thumbnalStorageId)
          .delete();

      await deleteAllDocument(
          postId: post.postId, inCollection: CollectionNames.comments);
      await deleteAllDocument(
          postId: post.postId, inCollection: CollectionNames.likes);

      // finally post in cllection
      final postInCollection = await FirebaseFirestore.instance
          .collection(CollectionNames.posts)
          .where(FirebaseFieldNames.posts, isEqualTo: post.postId)
          .limit(1)
          .get();

      for (final post in postInCollection.docs) {
        await post.reference.delete();
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteAllDocument({
    required PostId postId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 3),
      (transcations) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(FirebaseFieldNames.postId, isEqualTo: postId)
            .get();

        for (final doc in query.docs) {
          transcations.delete(doc.reference);
        }
      },
    );
  }
}

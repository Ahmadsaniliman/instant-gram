import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instantgram/Constants/Posts/collection_names.dart';
import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';
import 'package:instantgram/Widgets/Comment/comment_pay_load.dart';

class SendCommentNotifier extends StateNotifier<bool> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    try {
      final commentPayLoad = CommentPayLoad(
        userId: userId,
        comment: comment,
        postId: postId,
      );

      await FirebaseFirestore.instance
          .collection(CollectionNames.comments)
          .add(commentPayLoad);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

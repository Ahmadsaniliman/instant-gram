import 'package:instantgram/Constants/Posts/post_id.dart';
import 'package:instantgram/Constants/Posts/user_id.dart';

class LikesRequest {
  final PostId postId;
  final UserId likedBy;

  LikesRequest({
    required this.postId,
    required this.likedBy,
  });
}

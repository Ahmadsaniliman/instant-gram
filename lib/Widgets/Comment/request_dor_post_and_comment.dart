import 'package:instantgram/Constants/Posts/post_id.dart';

class RequestForPostAndComments {
  final PostId postId;
  final bool sortByCreatedAt;
  final int? limit;

  final DateSorting dateSorting;

  RequestForPostAndComments({
    required this.postId,
    required this.sortByCreatedAt,
    required this.limit,
    required this.dateSorting,
  });

  @override
  bool operator ==(covariant RequestForPostAndComments other) =>
      runtimeType == other.runtimeType &&
      postId == other.postId &&
      limit == other.limit &&
      dateSorting == other.dateSorting &&
      sortByCreatedAt == other.sortByCreatedAt;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          sortByCreatedAt,
          dateSorting,
          postId,
          limit,
        ],
      );
}

enum DateSorting {
  oldToNew,
  newToOld,
}

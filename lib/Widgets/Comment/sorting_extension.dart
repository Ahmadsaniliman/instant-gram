import 'package:instantgram/Widgets/Comment/comment.dart';
import 'package:instantgram/Widgets/Comment/request_dor_post_and_comment.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySorting(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sortedDocument = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.oldToNew:
              return b.createdAt.compareTo(a.createdAt);
            case DateSorting.newToOld:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocument;
    } else {
      return this;
    }
  }
}

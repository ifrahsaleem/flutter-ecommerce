import 'package:flutter_test/flutter_test.dart';
import 'package:team17_mobile/api/getCommentsapi.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/comment.dart';
import 'package:team17_mobile/viewmodels/commentviewmodel.dart';

class mockAllCommentsSingleProduct extends commentApi {
  @override
  Future<List<Comment>> getComments(String q) {
    return Future.value([
      Comment(
          approved: true,
          commentID: "60c27bcce72bb500156a4180",
          commentContent: "WOOOOOOW",
          user: "aguljahan00@gmail.com",
          rating: 5,
          v: 0,
      )
    ]);
  }
}

void main() {
  setupDependencyAssembler();
  var commentListViewModel = dependencyAssembler<commentmodel>();
  commentListViewModel.api = mockAllCommentsSingleProduct();
  String query = "60a7dc3dfb176100154c1128";
  group('Given a product id', () {
    test('Page should load a list of comments from backend', () async {
      await commentListViewModel.getComments(query);
      expect(commentListViewModel.comments[0].approved, true);
      expect(commentListViewModel.comments[0].user, "aguljahan00@gmail.com");
      expect(commentListViewModel.comments[0].rating, 5);
      expect(commentListViewModel.comments[0].commentContent, "WOOOOOOW");
      expect(commentListViewModel.comments[0].commentID, "60c27bcce72bb500156a4180");
      expect(commentListViewModel.comments[0].v, 0);
    });
  });
}






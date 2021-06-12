import 'package:team17_mobile/api/allOrders.dart';
import 'package:team17_mobile/api/cart.dart';
import 'package:team17_mobile/api/getCommentsapi.dart';
import 'package:team17_mobile/model/comment.dart';

import 'base_model.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';

class commentmodel extends BaseModel {
  commentApi api = dependencyAssembler<commentApi>();
  List<Comment> _comments;

  List<Comment> get comments {
    return _comments;
  }

  Future getComments(String q)
  async {
    applyState(ViewState.Busy);
    _comments = await api.getComments(q);
    applyState(ViewState.Idle);
  }
}
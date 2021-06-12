import 'package:team17_mobile/api/refundApi.dart';
import 'package:team17_mobile/model/refund_model.dart';
import 'base_model.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';

class refundModel extends BaseModel {
  refundApi api = dependencyAssembler<refundApi>();
  List<Refund> _refunds;

  List<Refund> get refunds {
    return _refunds;
  }

  Future getRefunds(String id)
  async {
    applyState(ViewState.Busy);
    _refunds = await api.getRefunds("id");
    applyState(ViewState.Idle);
  }
}
import 'package:team17_mobile/api/allOrders.dart';
import 'package:team17_mobile/api/allProducts.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/model/products.dart';

import 'base_model.dart';

class OrderListModel extends BaseModel {
  allOrdersAPI api = dependencyAssembler<allOrdersAPI>();
  List<Order> _orders;

  List<Order> get orders {
    return _orders;
  }

  Future getorder() async {
    applyState(ViewState.Busy);
    _orders = await api.getorder();
    applyState(ViewState.Idle);
  }
}
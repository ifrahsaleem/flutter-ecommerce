import 'package:team17_mobile/api/allOrders.dart';
import 'package:team17_mobile/api/cart.dart';
import 'package:team17_mobile/model/cart_model.dart';

import 'base_model.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/model/products.dart';

class cartListModel extends BaseModel {
  cartAPI api = dependencyAssembler<cartAPI>();
  List<Cart> _cart;

  List<Cart> get cart {
    return _cart;
  }

  Future getCartItems()
  async {
    applyState(ViewState.Busy);
    _cart = await api.getCartItems();
    applyState(ViewState.Idle);
  }
}
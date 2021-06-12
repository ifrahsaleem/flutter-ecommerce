import 'package:team17_mobile/api/allProducts.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/products.dart';

import 'base_model.dart';

class ProductListModel extends BaseModel {
  allProductsAPI api = dependencyAssembler<allProductsAPI>();
  List<Product> _products;

  List<Product> get products {
    return _products;
  }

  Future getinorder() async {
    applyState(ViewState.Busy);
    _products = await api.getinorder("");
    applyState(ViewState.Idle);
  }
}
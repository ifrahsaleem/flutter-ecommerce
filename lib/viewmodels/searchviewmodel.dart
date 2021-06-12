import 'package:team17_mobile/api/search_api.dart';
import 'package:team17_mobile/enums/view_state.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/products.dart';

import 'base_model.dart';

class SearchListModel extends BaseModel {
  SearchApi api = dependencyAssembler<SearchApi>();
  List<Product> _products;

  List<Product> get products {
    return _products;
  }

  Future getProducts() async {
    applyState(ViewState.Busy);
    _products = await SearchApi.getProducts("");
    applyState(ViewState.Idle);
  }
}
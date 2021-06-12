import 'package:get_it/get_it.dart';
import 'package:team17_mobile/api/allOrders.dart';
import 'package:team17_mobile/api/allProducts.dart';
import 'package:team17_mobile/api/cart.dart';
import 'package:team17_mobile/api/getCommentsapi.dart';
import 'package:team17_mobile/api/refundApi.dart';
import 'package:team17_mobile/api/search_api.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/viewmodels/allordersviewmodel.dart';
import 'package:team17_mobile/viewmodels/cartviewmodel.dart';
import 'package:team17_mobile/viewmodels/commentviewmodel.dart';
import 'package:team17_mobile/viewmodels/productviewmodels.dart';
import 'package:team17_mobile/viewmodels/refundViewmodel.dart';
import 'package:team17_mobile/viewmodels/searchviewmodel.dart';

GetIt dependencyAssembler = GetIt.instance;

void setupDependencyAssembler() {
  dependencyAssembler.registerLazySingleton(() => allProductsAPI());
  dependencyAssembler.registerFactory(() => ProductListModel());
  dependencyAssembler.registerLazySingleton(() => SearchApi());
  dependencyAssembler.registerFactory(() => SearchListModel());
  dependencyAssembler.registerFactory(() => OrderListModel());
  dependencyAssembler.registerLazySingleton(() => allOrdersAPI());
  dependencyAssembler.registerFactory(() => cartListModel());
  dependencyAssembler.registerLazySingleton(() => cartAPI());
  dependencyAssembler.registerLazySingleton(() => commentApi());
  dependencyAssembler.registerFactory(() => commentmodel());
  dependencyAssembler.registerLazySingleton(() => refundApi());
  dependencyAssembler.registerFactory(() => refundModel());

}
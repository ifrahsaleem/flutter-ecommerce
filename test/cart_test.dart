import 'package:flutter_test/flutter_test.dart';
import 'package:team17_mobile/api/cart.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/cart_model.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/viewmodels/cartviewmodel.dart';
import 'package:team17_mobile/viewmodels/productviewmodels.dart';

class mockAllCart extends cartAPI {

  @override
  Future<List<Cart>> getCartItems() {
    return Future.value([
      Cart(productId: "60a7dc07fb176100154c1126",
        productSize: "M",
        productName: "Jerry Q Art 12 PC White Synthetic",
        productCategory: "Brush",
        productDiscount: 5,
        productPrice: 29.95,
        productDCPrice: 28.45,
        productRating: 4,
        productFlutterLink: "https://cs308canvas.herokuapp.com/product/image/60a7dc07fb176100154c1126",
          quantity: 1,
      )
    ]);
  }
}


void main() {
  setupDependencyAssembler();
  var cartListViewModel = dependencyAssembler<cartListModel>();
  cartListViewModel.api = mockAllCart();

  group('Given Cart List Page Loads', () {
    test('Page should load a list of cart items from backend', () async {
      await cartListViewModel.getCartItems();
      expect(cartListViewModel.cart[0].productId, "60a7dc07fb176100154c1126");
      expect(cartListViewModel.cart[0].productSize, "M");
      expect(cartListViewModel.cart[0].productName, "Jerry Q Art 12 PC White Synthetic",);
      expect(cartListViewModel.cart[0].productCategory, "Brush");
      expect(cartListViewModel.cart[0].productDiscount, 5);
      expect(cartListViewModel.cart[0].productPrice, 29.95);
      expect(cartListViewModel.cart[0].productDCPrice, 28.45);
      expect(cartListViewModel.cart[0].productRating, 4,);
      expect(cartListViewModel.cart[0].productFlutterLink, "https://cs308canvas.herokuapp.com/product/image/60a7dc07fb176100154c1126");
      expect(cartListViewModel.cart[0].quantity, 1);
    });
  });
}
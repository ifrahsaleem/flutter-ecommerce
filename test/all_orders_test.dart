import 'package:flutter_test/flutter_test.dart';
import 'package:team17_mobile/api/allOrders.dart';
import 'package:team17_mobile/api/allProducts.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/viewmodels/allordersviewmodel.dart';
import 'package:team17_mobile/viewmodels/productviewmodels.dart';

class mockAllOrders extends allOrdersAPI {

  @override
  Future<List<Order>> getorder() {
    return Future.value([
      Order(status: "processing",
          orderID: "60c24844f73e33001572dcbe",
          name: "Ifrah Saleem",
          address: "abc abc",
          city: "Istanbul",
          country: "Turkey",
          userEmail: "ifrahsaleem123@gmail.com",
          date: "2021-06-10T17:13:40.826Z",
          total: "28.57",
          items: [],
          products: [Product(
              productSize: "Size 10",
              productDescription: "Paint beautiful and precise strokes with ease using this Royal & Langnickel Zen brush!",
              productStock: 27,
              productPrice: 5.99,
              productDiscount: 5,
              productBestseller: true,
              productNumofRatings: 12,
              productDistributor: "Zen",
              productBGcolor: "Peach",
              productComments: [
                "6071dede0172474870532391"
              ],
              productFlutterLink: "http://10.0.2.2:5000/product/image/606b0c26e8e7d76230b427c7",
              productId: "606b0c26e8e7d76230b427c7",
              productName: "Zen™ Series 43 Long Handle Filbert Brush",
              productCategory: "Brush",
              productRating: 4.2,
              productImageLink: "http://localhost:5000/product/image/606b0c26e8e7d76230b427c7",
              onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/606b0c26e8e7d76230b427c7"
          ),
            Product(
                productSize: "2",
                productDescription: "Express your creativity with these multi-use paintbrushes.",
                productStock: 8,
                productPrice: 12.99,
                productDiscount: 5,
                productBestseller: true,
                productNumofRatings: 11,
                productDistributor: "Loft® Necessities",
                productBGcolor: "Blue",
                productComments: [
                  "6071e8b7ddb95f84f4f7cdfe"
                ],
                productFlutterLink: "http://10.0.2.2:5000/product/image/606b1130275f386260dc79b4",
                productId: "606b1130275f386260dc79b4",
                productName: "White Synthetic Acrylic Round & Flat 10 Piece Brush Combo",
                productCategory: "Brush",
                productRating: 4.5,
                productImageLink: "http://localhost:5000/product/image/606b1130275f386260dc79b4",
                onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/606b1130275f386260dc79b4"
            ),
          ]
      )
    ]);
  }
}
  void main() {
    setupDependencyAssembler();
    var orderListViewModel = dependencyAssembler<OrderListModel>();
    orderListViewModel.api = mockAllOrders();

    group('Given Order List Page Loads', () {
      test('Page should load a list of orders from backend', () async {
        await orderListViewModel.getorder();
        expect(orderListViewModel.orders[0].status, 'processing');
        expect(orderListViewModel.orders[0].orderID, "60c24844f73e33001572dcbe");
        expect(orderListViewModel.orders[0].name, "Ifrah Saleem");
        expect(orderListViewModel.orders[0].address, "abc abc");
        expect(orderListViewModel.orders[0].city, "Istanbul");
        expect(orderListViewModel.orders[0].country, "Turkey");
        expect(orderListViewModel.orders[0].userEmail, "ifrahsaleem123@gmail.com");
        expect(orderListViewModel.orders[0].date, "2021-06-10T17:13:40.826Z");
        expect(orderListViewModel.orders[0].total, "28.57");
        expect(orderListViewModel.orders[0].items, []);
        expect(orderListViewModel.orders[0].products[0].productSize, "Size 10");
        expect(orderListViewModel.orders[0].products[0].productDescription, "Paint beautiful and precise strokes with ease using this Royal & Langnickel Zen brush!");
        expect(orderListViewModel.orders[0].products[0].productStock, 27);
        expect(orderListViewModel.orders[0].products[0].productPrice, 5.99);
        expect(orderListViewModel.orders[0].products[0].productDiscount, 5);
        expect(orderListViewModel.orders[0].products[0].productBestseller, true);
        expect(orderListViewModel.orders[0].products[0].productNumofRatings, 12);
        expect(orderListViewModel.orders[0].products[0].productDistributor, "Zen");
        expect(orderListViewModel.orders[0].products[0].productBGcolor, "Peach");
        expect(orderListViewModel.orders[0].products[0].productComments, [
          "6071dede0172474870532391"
        ]);
        expect(orderListViewModel.orders[0].products[0].productFlutterLink, "http://10.0.2.2:5000/product/image/606b0c26e8e7d76230b427c7");
        expect(orderListViewModel.orders[0].products[0].productId, "606b0c26e8e7d76230b427c7");
        expect(orderListViewModel.orders[0].products[0].productName, "Zen™ Series 43 Long Handle Filbert Brush");
        expect(orderListViewModel.orders[0].products[0].productCategory, "Brush");
        expect(orderListViewModel.orders[0].products[0].productRating, 4.2);
        expect(orderListViewModel.orders[0].products[0].productImageLink, "http://localhost:5000/product/image/606b0c26e8e7d76230b427c7");
        expect(orderListViewModel.orders[0].products[0].onlineImageLink, "https://cs308canvas.herokuapp.com/product/image/606b0c26e8e7d76230b427c7");

        expect(orderListViewModel.orders[0].products[1].productSize, "2");
        expect(orderListViewModel.orders[0].products[1].productDescription, "Express your creativity with these multi-use paintbrushes.");
        expect(orderListViewModel.orders[0].products[1].productStock, 8);
        expect(orderListViewModel.orders[0].products[1].productPrice, 12.99);
        expect(orderListViewModel.orders[0].products[1].productDiscount, 5);
        expect(orderListViewModel.orders[0].products[1].productBestseller, true);
        expect(orderListViewModel.orders[0].products[1].productNumofRatings, 11);
        expect(orderListViewModel.orders[0].products[1].productDistributor, "Loft® Necessities");
        expect(orderListViewModel.orders[0].products[1].productBGcolor, "Blue");
        expect(orderListViewModel.orders[0].products[1].productComments, [
          "6071e8b7ddb95f84f4f7cdfe"
        ]);
        expect(orderListViewModel.orders[0].products[1].productFlutterLink, "http://10.0.2.2:5000/product/image/606b1130275f386260dc79b4");
        expect(orderListViewModel.orders[0].products[1].productId, "606b1130275f386260dc79b4");
        expect(orderListViewModel.orders[0].products[1].productName, "White Synthetic Acrylic Round & Flat 10 Piece Brush Combo");
        expect(orderListViewModel.orders[0].products[1].productCategory, "Brush");
        expect(orderListViewModel.orders[0].products[1].productRating, 4.5);
        expect(orderListViewModel.orders[0].products[1].productImageLink, "http://localhost:5000/product/image/606b1130275f386260dc79b4");
        expect(orderListViewModel.orders[0].products[1].onlineImageLink, "https://cs308canvas.herokuapp.com/product/image/606b1130275f386260dc79b4");
      });
    });
  }
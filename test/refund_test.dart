import 'package:flutter_test/flutter_test.dart';
import 'package:team17_mobile/api/refundApi.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/model/refund_model.dart';
import 'package:team17_mobile/viewmodels/refundViewmodel.dart';

class mockRefundsSingleOrder extends refundApi {

  @override
  Future<List<Refund>> getRefunds(String id) {
    return Future.value([
      Refund(
          approved: false,
          refundId: "60b396bf68bac90015db0628",
          email:  "aguljahan00@gmail.com",
          invoiceID: "60b3962068bac90015db0626",
          product: Product(
            productId: "60a7d98bfb176100154c1120",
            productSize : "M",
            productDescription: "A high-quality, limited edition, digital illustration",
            productDistributor: "evieonoff",
            productBGcolor: "Peach",
            productName: "IT'S A LAND",
            productCategory: "Painting",

            productStock: 37,
            productDiscount: 5,
            productNumofRatings: 0,
            productBestseller: true,
            productPrice: 940.8,
            onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/60a7d98bfb176100154c1120",
            productDCPrice: 893.76,
          ),
          quantity: 1,
          priceAtPurchase: 893.76,
      ),
      Refund(
        approved: false,
        refundId: "60b397d268bac90015db0629",
        email:  "aguljahan00@gmail.com",
        invoiceID: "60b3962068bac90015db0626",
        product: Product(
          productId: "60a7d08cfb176100154c110f",
          productSize : "M",
          productDescription: "Acrylic Spray Paint, Rust proof for Internal and External applications. 15/45 mins drying time. A+ Certificate Emission. Available in 3 shades",
          productDistributor: "Nespoli Bravo",
          productBGcolor: "Peach",
          productName: "Rust Proof Spray Paint",
          productCategory: "Spray",

          productStock: 20,
          productDiscount: 5,
          productNumofRatings: 0,
          productBestseller: false,
          productPrice:  26.95,
          onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/60a7d08cfb176100154c110f",
          productDCPrice: 25.6,
        ),
        quantity: 1,
        priceAtPurchase: 25.6,
      ),
      Refund(
        approved: false,
        refundId: "60b397eb68bac90015db062a",
        email:  "aguljahan00@gmail.com",
        invoiceID: "60b3962068bac90015db0626",
        product: Product(
          productId: "60a7d08cfb176100154c110f",
          productSize : "M",
          productDescription: "Acrylic Spray Paint, Rust proof for Internal and External applications. 15/45 mins drying time. A+ Certificate Emission. Available in 3 shades",
          productDistributor: "Nespoli Bravo",
          productBGcolor: "Peach",
          productName: "Rust Proof Spray Paint",
          productCategory: "Spray",

          productStock: 20,
          productDiscount: 5,
          productNumofRatings: 0,
          productBestseller: false,
          productPrice:  26.95,
          onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/60a7d08cfb176100154c110f",
          productDCPrice: 25.6,
        ),
        quantity: 1,
        priceAtPurchase: 25.6,
      ),
      Refund(
        approved: false,
        refundId: "60c27644e72bb500156a417e",
        email:  "aguljahan00@gmail.com",
        invoiceID: "60b3962068bac90015db0626",
        product: Product(
          productId: "60a7d98bfb176100154c1120",
          productSize : "M",
          productDescription: "A high-quality, limited edition, digital illustration",
          productDistributor: "evieonoff",
          productBGcolor: "Peach",
          productName:  "IT'S A LAND",
          productCategory: "Painting",

          productStock: 37,
          productDiscount: 5,
          productNumofRatings: 0,
          productBestseller: true,
          productPrice:  940.8,
          onlineImageLink: "https://cs308canvas.herokuapp.com/product/image/60a7d98bfb176100154c1120",
          productDCPrice: 893.76,
        ),
        quantity:  2,
        priceAtPurchase:  893.76,
      ),
    ]);
  }
}


void main() {
  setupDependencyAssembler();
  var refundListViewModel = dependencyAssembler<refundModel>();

  refundListViewModel.api = mockRefundsSingleOrder();

  String query = "60b3962068bac90015db0626";

  group('Given an invoice id', () {
    test('Page should load a list of refunded/cancelled items from backend', () async {
      await refundListViewModel.getRefunds(query);
      expect(refundListViewModel.refunds[0].approved, false);
      expect(refundListViewModel.refunds[0].refundId,  "60b396bf68bac90015db0628");
      expect(refundListViewModel.refunds[0].email,  "aguljahan00@gmail.com");
      expect(refundListViewModel.refunds[0].invoiceID, query);
      expect(refundListViewModel.refunds[0].product.productId,  "60a7d98bfb176100154c1120");
      expect(refundListViewModel.refunds[0].product.productSize,  "M");
      expect(refundListViewModel.refunds[0].product.productName,  "IT'S A LAND");
      expect(refundListViewModel.refunds[0].product.productPrice,  940.8);
      expect(refundListViewModel.refunds[0].product.productDCPrice,  893.76);
      expect(refundListViewModel.refunds[0].quantity, 1);
      expect(refundListViewModel.refunds[0].priceAtPurchase,  893.76);

      expect(refundListViewModel.refunds[1].approved, false);
      expect(refundListViewModel.refunds[1].refundId,  "60b397d268bac90015db0629");
      expect(refundListViewModel.refunds[1].email,  "aguljahan00@gmail.com");
      expect(refundListViewModel.refunds[1].invoiceID, query);
      expect(refundListViewModel.refunds[1].product.productId,  "60a7d08cfb176100154c110f");
      expect(refundListViewModel.refunds[1].product.productSize,  "M");
      expect(refundListViewModel.refunds[1].product.productName,  "Rust Proof Spray Paint");
      expect(refundListViewModel.refunds[1].product.productPrice,  26.95);
      expect(refundListViewModel.refunds[1].product.productDCPrice,  25.6);
      expect(refundListViewModel.refunds[1].quantity, 1);
      expect(refundListViewModel.refunds[1].priceAtPurchase, 25.6);

      expect(refundListViewModel.refunds[2].approved, false);
      expect(refundListViewModel.refunds[2].refundId,  "60b397eb68bac90015db062a");
      expect(refundListViewModel.refunds[2].email,  "aguljahan00@gmail.com");
      expect(refundListViewModel.refunds[2].invoiceID, query);
      expect(refundListViewModel.refunds[2].product.productId,  "60a7d08cfb176100154c110f");
      expect(refundListViewModel.refunds[2].product.productSize,  "M");
      expect(refundListViewModel.refunds[2].product.productName,  "Rust Proof Spray Paint");
      expect(refundListViewModel.refunds[2].product.productPrice,  26.95);
      expect(refundListViewModel.refunds[2].product.productDCPrice,  25.6);
      expect(refundListViewModel.refunds[2].quantity, 1);
      expect(refundListViewModel.refunds[2].priceAtPurchase, 25.6);

      expect(refundListViewModel.refunds[3].approved, false);
      expect(refundListViewModel.refunds[3].refundId,  "60c27644e72bb500156a417e");
      expect(refundListViewModel.refunds[3].email,  "aguljahan00@gmail.com");
      expect(refundListViewModel.refunds[3].invoiceID, query);
      expect(refundListViewModel.refunds[3].product.productId,  "60a7d98bfb176100154c1120");
      expect(refundListViewModel.refunds[3].product.productSize,  "M");
      expect(refundListViewModel.refunds[3].product.productName,  "IT'S A LAND");
      expect(refundListViewModel.refunds[3].product.productPrice,   940.8);
      expect(refundListViewModel.refunds[3].product.productDCPrice,  893.76);
      expect(refundListViewModel.refunds[3].quantity, 2);
      expect(refundListViewModel.refunds[3].priceAtPurchase, 893.76);
    });
  });
}
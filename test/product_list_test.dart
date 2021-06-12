import 'package:flutter_test/flutter_test.dart';
import 'package:team17_mobile/api/allProducts.dart';
import 'package:team17_mobile/helpers/dependency_assembly.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/viewmodels/productviewmodels.dart';

class mockAllProducts extends allProductsAPI {
  String value = "";

  @override
  Future<List<Product>> getinorder(value) {
    return Future.value([
      Product(
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
    ]);
  }
}

void main() {
  setupDependencyAssembler();
  var productListViewModel = dependencyAssembler<ProductListModel>();
  productListViewModel.api = mockAllProducts();

  group('Given Product List Page Loads', () {
    test('Page should load a list of products from backend', () async {
      await productListViewModel.getinorder();
      expect(productListViewModel.products.length, 2);
      expect(productListViewModel.products[0].productSize, "Size 10");
      expect(productListViewModel.products[0].productDescription, "Paint beautiful and precise strokes with ease using this Royal & Langnickel Zen brush!");
      expect(productListViewModel.products[0].productStock, 27);
      expect(productListViewModel.products[0].productPrice, 5.99);
      expect(productListViewModel.products[0].productDiscount, 5);
      expect(productListViewModel.products[0].productBestseller, true);
      expect(productListViewModel.products[0].productNumofRatings, 12);
      expect(productListViewModel.products[0].productDistributor, "Zen");
      expect(productListViewModel.products[0].productBGcolor, "Peach");
      expect(productListViewModel.products[0].productComments, [
        "6071dede0172474870532391"
        ]);
      expect(productListViewModel.products[0].productFlutterLink, "http://10.0.2.2:5000/product/image/606b0c26e8e7d76230b427c7");
      expect(productListViewModel.products[0].productId, "606b0c26e8e7d76230b427c7");
      expect(productListViewModel.products[0].productName, "Zen™ Series 43 Long Handle Filbert Brush");
      expect(productListViewModel.products[0].productCategory, "Brush");
      expect(productListViewModel.products[0].productRating, 4.2);
      expect(productListViewModel.products[0].productImageLink, "http://localhost:5000/product/image/606b0c26e8e7d76230b427c7");
      expect(productListViewModel.products[0].onlineImageLink, "https://cs308canvas.herokuapp.com/product/image/606b0c26e8e7d76230b427c7");

      expect(productListViewModel.products[1].productSize, "2");
      expect(productListViewModel.products[1].productDescription, "Express your creativity with these multi-use paintbrushes.");
      expect(productListViewModel.products[1].productStock, 8);
      expect(productListViewModel.products[1].productPrice, 12.99);
      expect(productListViewModel.products[1].productDiscount, 5);
      expect(productListViewModel.products[1].productBestseller, true);
      expect(productListViewModel.products[1].productNumofRatings, 11);
      expect(productListViewModel.products[1].productDistributor, "Loft® Necessities");
      expect(productListViewModel.products[1].productBGcolor, "Blue");
      expect(productListViewModel.products[1].productComments, [
        "6071e8b7ddb95f84f4f7cdfe"
      ]);
      expect(productListViewModel.products[1].productFlutterLink, "http://10.0.2.2:5000/product/image/606b1130275f386260dc79b4");
      expect(productListViewModel.products[1].productId, "606b1130275f386260dc79b4");
      expect(productListViewModel.products[1].productName, "White Synthetic Acrylic Round & Flat 10 Piece Brush Combo");
      expect(productListViewModel.products[1].productCategory, "Brush");
      expect(productListViewModel.products[1].productRating, 4.5);
      expect(productListViewModel.products[1].productImageLink, "http://localhost:5000/product/image/606b1130275f386260dc79b4");
      expect(productListViewModel.products[1].onlineImageLink, "https://cs308canvas.herokuapp.com/product/image/606b1130275f386260dc79b4");
    });
  });
}
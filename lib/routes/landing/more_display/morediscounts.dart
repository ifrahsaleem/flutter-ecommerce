import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/allproducts/components/itemcard.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class moreDiscounts extends StatefulWidget {
  @override
  _moreDiscountsState createState() => _moreDiscountsState();
}

class _moreDiscountsState extends State<moreDiscounts> {

  List<Product> products;
  Future<List<Product>> getinorder() async {
    final response1 = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/product/discounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response1.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body);
      products = body1.map((dynamic item) => Product.fromJson(item)).toList();
      print(products.length);
      return products;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20.0, 100.0, 1.0),
              child: Text(
                "Discounted Products",
                style: TextStyle(
                  fontFamily: 'Lexend-Thin',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: FutureBuilder(
        future: getinorder(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('There was an error :(');
          } else if (snapshot.hasData) {
            print('here');
            print(snapshot.data);
            return (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimen.largeMargin),
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: Dimen.largeMargin,
                        crossAxisSpacing: Dimen.largeMargin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                        product: snapshot.data[index],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SingleProduct(id: products[index].productId),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ));
          } else {
            print(snapshot.data);
            return (Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        AppColors.orangelighttone))));
          }
        },
      ),
    );
  }
}


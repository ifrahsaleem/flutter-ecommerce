import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/allproducts/components/itemcard.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/drawer/drawer.dart';
import 'package:team17_mobile/routes/orderDetails/orderDetails.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Displayproducts extends StatefulWidget {
  @override
  _DisplayproductsState createState() => _DisplayproductsState();
}

class _DisplayproductsState extends State<Displayproducts> {
  String value = "";

  List<Product> products;
  Future<List<Product>> getinorder(String order) async {
    var query = {'order': value.toLowerCase()};
    final response1 = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/product/filter', query),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response1.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body);
      products = body1.map((dynamic item) => Product.fromJson(item)).toList();
      print(products.length);
      print(products[0].productId);
      return products;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // Assign that variable your Future.
    getinorder(value);
    print(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20.0, 70.0, 1.0),
              child: Text(
                "All Products",
                style: TextStyle(
                  fontFamily: 'Lexend-Thin',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            child: PopupMenuButton<String>(
              onSelected: (String link) {
                //print(link);
                setState(() {
                  value = link;
                });
              },
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String link) {
                  return PopupMenuItem<String>(
                    value: link,
                    child: Text(link),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder(
        future: getinorder(
            value), //TODO:PROBLEM HERE,solution1(not problem area anymore)
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

class Constants {
  static const String ascending = "Ascending";
  static const String descending = "Descending";
  static const String ratings = "Ratings";

  static const List<String> choices = <String>[
    ascending,
    descending,
    ratings,
  ];
}
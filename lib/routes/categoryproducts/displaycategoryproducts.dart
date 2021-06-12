import 'package:flutter/material.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/routes/categoryproducts/components/itemcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisplayCategoryProducts extends StatefulWidget {
  final String value;

  DisplayCategoryProducts({
    Key key,
    this.value,
  }) : super(key: key);

  @override
  _DisplayCategoryProductsState createState() =>
      _DisplayCategoryProductsState(value);
}

class _DisplayCategoryProductsState extends State<DisplayCategoryProducts> {
  String value = "";
  String order = "";

  _DisplayCategoryProductsState(this.value);

  List<Product> products;
  Future<List<Product>> getCategoryProducts(String order) async {
    var queryParameters = {'categories': this.value, 'order': order};
    List data;
    final response = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/product/filter', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(response.body);
      products = body.map((dynamic product) => Product.fromJson(product)).toList();
      print(products.length);
      return products;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future myFuture;

  @override
  void initState() {
    // Assign that variable your Future.
    getCategoryProducts(order);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: AppColors.textColor,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 20.0, 70.0, 1.0),
                child: Text(
                  "Category Products",
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
                  print(link);
                  setState(() {
                    order = link;
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
      ),
      body: FutureBuilder(
        future: getCategoryProducts(order),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              'There was an error :(',
              //style: Theme.of(context).textTheme.headline,
            );
          } else if (snapshot.hasData) {
            print('here');
            print(snapshot.data);
            return (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
                  child: Text(
                    this.value,
                    style: kHeadingSmallTextStyle,
                  ),
                ),
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
                              builder: (context) =>SingleProduct(id: products[index].productId),
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
  static const String ascending = "ascending";
  static const String descending = "descending";
  static const String ratings = "ratings";

  static const List<String> choices = <String>[
    ascending,
    descending,
    ratings,
  ];
}

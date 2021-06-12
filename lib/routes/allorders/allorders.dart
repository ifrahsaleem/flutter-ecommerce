import 'dart:async';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/global/totalPrice.dart';
import 'package:team17_mobile/routes/cart/cart_card.dart';
import 'package:team17_mobile/routes/cart/check_out_card.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/routes/orderDetails/orderDetails.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'ordertile.dart';

class AllOrdersScreen extends StatefulWidget {
  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  String value = "";
  StreamController _streamController1;
  Stream _stream;
  List<Order> products;
  Future<List<Order>> getallorders() async {
    final response1 = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/purchase'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie
      },
    );
    if (response1.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body);
      products = body1.map((dynamic item) => Order.fromJson(item)).toList();
      _streamController1.add(products);
      return products;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Stream<List<Order>> getCartView() async* {
    //await Future.delayed(Duration(seconds: 1));
    yield await getallorders();
  }

  @override
  void initState() {
    // Assign that variable your Future.
    super.initState();
    _streamController1 = StreamController();
    _stream = _streamController1.stream;
    getallorders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Orders',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.textColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getallorders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('There was an error :(');
          } else if (snapshot.hasData) {
            print(snapshot.data.length);
            return (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimen.regularMargin),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) =>
                          OrderCard(
                            order: snapshot.data[index],
                          press: () => Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>
                               OrderDetails(orderId: products[index].orderID)// "6092e5bca12d61612c393abf"),//products[index].orderID),
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

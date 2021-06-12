import 'dart:async';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/global/totalPrice.dart';
import 'package:team17_mobile/routes/cart/cart_card.dart';
import 'package:team17_mobile/routes/cart/check_out_card.dart';
import 'package:team17_mobile/model/cart_model.dart';
import 'package:team17_mobile/routes/drawer/drawer.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StreamController _streamController;
  Stream _stream;
  List<Cart> demoCarts;

  getCartItems() async {
    final url1 = Uri.parse('https://cs308canvas.herokuapp.com');
    List data;

    final response = await http.get(
      Uri.http(url1.authority, '/cart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
     if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
      }
      List<dynamic> body = jsonDecode(response.body);
      demoCarts = body.map((dynamic item) => Cart.fromJson(item)).toList();
      print(demoCarts.length);
      _streamController.add(demoCarts);
      totalPrice = calculateTotal();
      return demoCarts;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<void> deleteCartItems(String id, dynamic quantity) async {
    final url1 = Uri.parse('https://cs308canvas.herokuapp.com');
    List data;
    final response = await http.delete(
      Uri.http(url1.authority, '/cart/remove/${id}/${quantity}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie
      },
    );
    if (response.statusCode == 200) {
      if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
      }

    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Stream<List<Cart>> getCartView() async* {
    print('cartview');
      //await Future.delayed(Duration(seconds: 1));
      yield await getCartItems();
  }

  dynamic calculateTotal() {
    if(demoCarts != null) {
      double sum = 0;
      for (int i = 0; i < demoCarts.length; i++) {
        sum = sum + (demoCarts[i].productDCPrice * demoCarts[i].quantity);
      }
      return double.parse((sum).toStringAsFixed(2));
    }
  }

  @override
  void initState() {
    // Assign that variable your Future.
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getCartItems();
    // totalPrice = calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            backgroundColor: AppColors.textColor,
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20.0, 170.0, 5.0),
                  child: Column(
                    children: [
                      Text("Cart",
                        style: TextStyle(
                          fontFamily: 'Lexend-Thin',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  )
              ),
            ],
            centerTitle: true,
          ),
        ),
        drawer: buildDrawer(context),
        body:
        StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'There was an error :(',
                  //style: Theme.of(context).textTheme.headline,
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                deleteCartItems(demoCarts[index].productId, demoCarts[index].quantity);
                                demoCarts.removeAt(index);
                                totalPrice = calculateTotal();
                              });
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/images/Trash.svg"),
                                ],
                              ),
                            ),
                            child: CartCard(cart: snapshot.data[index]),
                          ),
                        ),
                  ),
                );
              }
              else {
                print(snapshot.data);
                return (Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            AppColors.orangelighttone))));
              }
            }
        ),
        bottomNavigationBar: CheckoutCard(totalPrice: totalPrice)
    );
  }
}

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

class cartAPI {

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
      if (response.headers['set-cookie'] != null) {
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
      }
      List<dynamic> body = jsonDecode(response.body);
      demoCarts = body.map((dynamic item) => Cart.fromJson(item)).toList();
      return demoCarts;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/global/totalPrice.dart';
import 'package:team17_mobile/routes/cart/cart.dart';
import 'package:team17_mobile/routes/checkout/cart_total.dart';
import 'package:team17_mobile/utils/color.dart';
import 'dart:convert';
import '../model/login_model.dart';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel, BuildContext context) async {
    final response = await http.post(
      Uri.http('cs308canvas.herokuapp.com', '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': Global.cookie,
      },
      body: jsonEncode(<String, String>{
        'email': requestModel.email,
        'password' : requestModel.password
      }),
    );
    if (response.statusCode == 200) {
      Global.loggedIn = 1;
      if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
        print(Global.cookie);
      }

      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      print(LoginResponseModel.fromJson(jsonDecode(response.body)));
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: response.body,
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 3),
      );

    }
  }
}
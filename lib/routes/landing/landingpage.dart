import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/routes/drawer/drawer.dart';
import 'package:team17_mobile/routes/landing/widgets/Horizotallist.dart';
import 'package:team17_mobile/routes/landing/widgets/bodylanding.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';

import 'package:team17_mobile/routes/landing/widgets/features.dart';
import 'package:team17_mobile/utils/color.dart';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  Future<void> logOut() async {
    final url = Uri.parse('https://cs308canvas.herokuapp.com/logout');
    var body = {
    };

    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        'cookie': Global.cookie,
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //successful transmission

      Global.loggedIn = 0;

      Global.cookie = "";
      Navigator.pushReplacementNamed(context, '/welcome');
    }else{
      throw Exception();
    }

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      drawer: buildDrawer(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.textColor, //AppColors.textColor ,
      elevation: 0,
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({@required this.text, this.size,this.color,this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(fontSize: size ?? 16, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.normal),
    );
  }
}

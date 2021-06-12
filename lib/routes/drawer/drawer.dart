import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/routes/landing/widgets/Horizotallist.dart';
import 'package:team17_mobile/routes/landing/widgets/bodylanding.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';
import 'package:team17_mobile/routes/landing/widgets/features.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';

Drawer buildDrawer(context) {
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
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: new BoxDecoration(
            color: AppColors.textColor, //AppColors.textColor,
          ),
          child: Image.asset('assets/logo101.png', height: 280,)
        ),

        InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: ListTile(
            title: Text('Home Page'),
            leading: Icon(Icons.home),
          ),
        ),

        Visibility(
          visible: Global.loggedIn == 1 ? true : false,
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/allorders');
            },
            child: ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.shopping_basket),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/productcategories');
          },
          child: ListTile(
            title: Text('Categories'),
            leading: Icon(Icons.dashboard),
          ),
        ),

        InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/productsTab');
          },
          child: ListTile(
            title: Text('All Products'),
            leading: Icon(Icons.shopping_bag),
          ),
        ),

        Divider(),

        Visibility(
          visible: Global.loggedIn == 1 ? true : false,
          child: InkWell(
            onTap: (){
              logOut();
            },
            child: ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
            ),
          ),
        ),

        Visibility(
          visible: Global.loggedIn == 0 ? true : false,
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/login');
            },
            child: ListTile(
              title: Text('Log In'),
              leading: Icon(Icons.login, color: Colors.grey,),
            ),
          ),
        ),
      ],
    ),
  );
}


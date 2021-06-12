import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:http/http.dart' as http;

class Dummy extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {



  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Canvas',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.textColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: display(),
    );
  }

  Widget display(){
    if(Global.loggedIn != 0){
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 80,),
              Text(
                "We are sad that you are leaving! :(",
                textAlign: TextAlign.justify,
                style:
                TextStyle(color: AppColors.textColor, fontSize: 20, height: 1, fontFamily: 'Lexend'),

              ),
              SizedBox(
                width: 190,
                child: OutlinedButton(
                  onPressed: () {
                   // logOut();
                    Navigator.pushReplacementNamed(context, '/welcome');
                  },
                  child: Text('Log Out', style: kButtonDarkTextStyle),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }else{
      return Center(
        child: Text(
          "You are not logged in :(",
          textAlign: TextAlign.justify,
          style:
          TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20, height: 1, fontFamily: 'Lexend'),
        ),
      );
    }
  }
}



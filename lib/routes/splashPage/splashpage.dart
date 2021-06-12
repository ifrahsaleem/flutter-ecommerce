import 'package:flutter/material.dart';
import 'dart:async';
import 'package:team17_mobile/utils/color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => Navigator.pushReplacementNamed(context, "/welcome"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: AppColors.textColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/logo101.png'),
                        radius: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                      Text(
                        "Canvas",
                        style: TextStyle(
                          fontFamily: 'Lexend-Thin',
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator.adaptive(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Column(
                      children: [
                        Text(
                          "For Minds That Create",
                          style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFffffff)),
                        ),
                        Text(
                          "One Stop Store for Art Supplies",
                          style: TextStyle(
                            fontFamily: 'Lexend-Bold',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

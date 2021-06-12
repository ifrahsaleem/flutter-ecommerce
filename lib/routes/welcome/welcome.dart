import 'package:flutter/material.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.darkgreyblack,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
              width: double.infinity,
             // height: MediaQuery.of(context).size.height/3,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Welcome to Canvas", style: kHeadingTextStyle ,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/logo101.png'),
                      radius: 140,
                    ),
                  ),
                  Column(

                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 340.0,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),

                          child: OutlinedButton(

                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),

                              ),
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 30),
                              child: Text(
                                  'Login',
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: -0.7,
                                      fontFamily: 'OpenSansCondensed-Light'
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height:15),
                      Container(
                        height: 50.0,
                        width: 340.0,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),

                          child: OutlinedButton(

                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),

                              ),
                              backgroundColor: AppColors.textColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                              child: Text(
                                  'Sign up',
                                  style:  TextStyle(
                                      color:  Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: -0.7,
                                      fontFamily: 'OpenSansCondensed-Light'
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height:15),
                      Container(
                        height: 50.0,
                        width: 340.0,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),

                          child: OutlinedButton(

                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),

                              ),
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
                              child: Text(
                                  'Skip',
                                  style:  TextStyle(
                                      color:  Colors.white,
                                      fontSize: 20.0,
                                      letterSpacing: -0.7,
                                      fontFamily: 'OpenSansCondensed-Light'
                                  )
                              ),
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height:20),
                    ],
                  )
                ],
              )

          )
      ),
    );
  }
}
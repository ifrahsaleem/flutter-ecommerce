import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/model/formvalidator_model.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int attemptCount = 0;
  String email;
  String password;
  String password2;
  String fullName;
  String taxID;
  String address;
  String city;
  String country;

  final _formKey = GlobalKey<FormState>();

  Future<void> signUpUser() async {
    final url = Uri.parse('https://cs308canvas.herokuapp.com/register');
    var body = {
      'call': 'signup',
      'email': email,
      'password': password,
      'fullName': fullName,
      'taxID': taxID,
      'address': address,
      'city': city,
      'country': country,
    };
    print("here");

    print(taxID);

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
    print("lol");
    print(response.statusCode);
    print("wth");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //successful transmission
      Global.loggedIn = 1;
      if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
      }
      Navigator.pushNamed(context, '/authentication');
    } else if (response.statusCode >= 400 && response.statusCode < 500) {

      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'This email address is already registered',
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 3),
      );
    } else {
      print(response.statusCode);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Error!",
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 3),
      );
    }

  }
  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title,
              textAlign: TextAlign.justify,
              style:
              TextStyle(color: AppColors.primary, fontSize: 24, height: 1, fontFamily: 'Lexend'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message,
                    textAlign: TextAlign.justify,
                    style:
                    TextStyle(color: AppColors.textColor, fontSize: 20, height: 1, fontFamily: 'Lexend'),),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK',
                  style:
                  TextStyle(color: AppColors.textColor, fontSize: 16, height: 1, fontFamily: 'Lexend'),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.textColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimen.regularPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Center(
                  child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(0.1),
                    child: Image(
                      image: AssetImage('assets/13014.jpg'),
                    ))
              ])),
              SizedBox(height: 10.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'E-mail',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'The e-mail address is not valid';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              email = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Full Name',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: AppColors.secondary),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              if (!value.contains(" ") || value.length <3) {
                                return 'The full name is not valid';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              fullName = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Tax ID',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondary),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your tax Id';
                              }
                              if (value.length < 6) {
                                //return 'Invalid Tax Id';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              taxID = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Address',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondary),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your address';
                              }
                              if (value.length < 3) {
                                return 'Invalid address';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              address = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'City',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondary),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator:  (value) {
                              if (value.isEmpty) {
                                return 'Please enter your city';
                              }
                              if (value.length < 3) {
                                return 'Invalid city';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              city = value;
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Country',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.secondary),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator:  (value) {
                                  if (value.isEmpty) {
                                     return 'Please enter your country';
                                  }
                                 if (value.length < 2) {
                                    return 'Invalid Country';
                                   }
                                   return null;
                               },
                            onSaved: (String value) {
                              country = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Password',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: FormValidator.validatePassword,

                            onSaved: (String value) {
                              password = value;
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.captionColor,
                              filled: true,
                              hintText: 'Confirm Password',
                              //labelText: 'username',
                              labelStyle: kLabelLightTextStyle,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.secondary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: FormValidator.validatePassword,

                            onSaved: (String value) {
                              password2 = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                if (password != password2) {
                                  showAlertDialog(
                                      "Error", "Passwords don't match");
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    // if all are valid then go to success screen
                                    signUpUser();


                                  }
                                }
                                //

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Signing up')));
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Sign Up',
                                style: kButtonDarkTextStyle,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

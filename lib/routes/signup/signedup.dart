import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool verified = false;
  int attemptCount;
  String passCode;
  final _formKey = GlobalKey<FormState>();
  Future<void> verifyPasscode() async {
    final url = Uri.parse('https://cs308canvas.herokuapp.com/authenticate/passcode');
    var body = {
      'passcode': passCode,
    };

    final response = await http.put(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        'cookie': Global.cookie,
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );
    print("this");
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //successful transmission
      print("it is 200");
      print(response.body);
      if (response.headers['set-cookie'] != null) {
        print("hi");
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
        print('after: ');
        print(Global.cookie);
      }
      await showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('\nSuccessful Email Authentication!\n',
                textAlign: TextAlign.center,
                style:
                TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 16, height: 1, fontFamily: 'Lexend'),),
            );
          });

      Navigator.pushReplacementNamed(context, '/home');

    }else {
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
  // Global.loggedIn = 1;
  @override
  void initState() {

    super.initState();
    attemptCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Passcode Verification',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.textColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: Dimen.regularPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Column(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(0.1),
                        child: Image(
                          image: AssetImage('assets/images/undraw_authentication_fsn5.png'),
                          width: 350,
                          height: 230,
                        )
                    )
                  ])
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 270,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.captionColor,
                                filled: true,
                                hintText: 'Enter the passcode',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.secondary),
                                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'Please enter the passcode';
                                // ignore: missing_return, missing_return
                                }
                              },
                              onSaved: (String value) {
                                passCode = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16,),
                    Container(
                      width: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                if(_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                   verifyPasscode();
                                   print(verified);

                                  //showAlertDialog("Action", 'Button clicked');
                                  setState(() {
                                    attemptCount += 1;
                                  });
                                }
                              },

                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 9.0),
                                child: Text(
                                  'Confirm',
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

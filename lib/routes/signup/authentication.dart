import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication extends StatefulWidget {
  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<Authentication> {

  int attemptCount;
  String passCode;
  final _formKey = GlobalKey<FormState>();

  Future<void> sendEmail() async {
    final url = Uri.parse('https://cs308canvas.herokuapp.com/authenticate/sendemail');
    var body = {
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
              title: Text('\nSuccess!\n Please, check your inbox!',
                textAlign: TextAlign.center,
                style:
                TextStyle(color: AppColors.primary, fontSize: 16, height: 1, fontFamily: 'Lexend'),),
            );
          });
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
          'Email Authentication',
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
                          height: 250,
                        )
                    )
                  ])
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Authentication passcode will be sent to your email',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: AppColors.textColor, fontSize: 16, height: 1, fontFamily: 'Lexend'),
                  )),
                  SizedBox(height:20),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    textColor: Colors.white,
                    color: AppColors.primary,
                    child: Text("Press to get the passcode"),
                    onPressed: () {
                         sendEmail();
                         Navigator.pushNamed(context, '/confirmpasscode');
                        //showAlertDialog("Action", 'Button clicked');
                        setState(() {
                          attemptCount += 1;
                        });
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

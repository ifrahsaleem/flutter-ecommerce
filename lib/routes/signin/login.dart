import 'package:team17_mobile/model/formvalidator_model.dart';
import 'package:team17_mobile/routes/allorders/allorders.dart';
import 'package:team17_mobile/routes/cart/cart.dart';
import 'package:team17_mobile/routes/commentsratings/addCommentsRatings.dart';
import 'package:team17_mobile/routes/homepage/homePage.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/api/login_response.dart';
import 'package:team17_mobile/model/login_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginRequestModel loginRequestModel;
  int attemptCount;
  bool isApiCallProcess = false;
  String mail;
  String pass;
  bool remember = false;
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  // final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  // GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
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
    print('Build called');
    // return ScaffoldMessenger(
    //     key: scaffoldMessengerKey,
    //
    //   child :
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        print('G');
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Sign In',
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
                // Spacer(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset('assets/images/artist1.png',
                      ),
                ),
                // Spacer(),
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
                                // labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.textColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: FormValidator.validateEmail,
                              //     (value) {
                              //   if (value.isEmpty) {
                              //     return 'Please enter your e-mail';
                              //   }
                              //   if (!EmailValidator.validate(value)) {
                              //     return 'The e-mail address is not valid';
                              //   }
                              //   return null;
                              // },
                              onSaved: (input) => loginRequestModel.email = input,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: AppColors.captionColor,
                                filled: true,
                                hintText: 'Password',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.primary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: FormValidator.validatePassword,
                              //     (value) {
                              //   if (value.isEmpty) {
                              //     return 'Please enter your password';
                              //   }
                              //   if (value.length < 8) {
                              //     return 'Password must be at least 8 characters';
                              //   }
                              //   return null;
                              // },
                              onSaved: (input) =>
                                  loginRequestModel.password = input,
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

                                  setState(() {
                                    isApiCallProcess = true;
                                  });

                                  LoginService apiService = new LoginService();
                                  apiService
                                      .login(loginRequestModel, context)
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      if (value == null) {
                                        Text('Invalid Credentials!');
                                      }
                                      if (value.token.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('Logging in')));
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()
                                              // CartScreen()
                                              // AddCommentsRatings()
                                              // AllOrdersScreen()
                                            ));
                                      } else {
                                        print('error');
                                        Text('Invalid Credentials!');
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(content: Text('Invalid Credentials!')));
                                        // final snackBar =
                                        // SnackBar(content: Text(value.error));
                                        // scaffoldMessengerKey.currentState
                                        //     .showSnackBar(snackBar);
                                      }
                                    }
                                  });
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Login',
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Don’t have an account? ",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, "/signup"),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.textColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}

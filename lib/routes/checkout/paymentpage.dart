import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';

class CreditCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditCardPageState();
  }
}
class CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> send2 () async{
    final url = Uri.parse('https://cs308canvas.herokuapp.com/purchase/step2');
    final respo = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        'Cookie': Global.cookie,
      },
      body: {
        "CardNumber": cardNumber,
        "Date": expiryDate,
        "PIN": cvvCode,
        "CardName": cardHolderName,

      }, encoding: Encoding.getByName("utf-8"),);
    print(respo.statusCode);
    if (respo.statusCode >= 200 && respo.statusCode < 300) {
      print(respo.body);
      if (respo.headers['set-cookie'] != null){
        var myCookie = respo.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
        print('after: ');
        print(Global.cookie);
      }
    } else if (respo.statusCode >= 400 && respo.statusCode < 500) {
      print("hello im 404");

    } else {
      print(jsonDecode(respo.body.toString()).toString());
      print(respo.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        elevation: 0.0,
        title: Text('Payment Information'),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardBgColor: AppColors.primary,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              width: MediaQuery.of(context).size.width,
              //animationDuration: Duration(milliseconds: 1000),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      onCreditCardModelChange: onCreditCardModelChange,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        focusColor: AppColors.secondary,
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Holder Name',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primary)),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: const Text('Validate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          print('valid!');
                          send2();
                          Navigator.pushReplacementNamed(context, '/invoice');

                        } else {
                          print('invalid!');
                          _showValidDialog(
                              context,
                              "Invalid or Incomplete Credentials",
                              "Please try again!");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<AlertDialog> _showValidDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.textColor,
          title: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          content: Text(
            content,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.primary)),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      print(expiryDate);
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

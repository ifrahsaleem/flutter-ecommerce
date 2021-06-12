import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  String customer_info;
  String Shipping_handstreet,Shipping_city,Shipping_country;
  String Billing_handstreet,Billing_city,Billing_country;

  int price;

  Future<void> send1 () async{

    final url = Uri.parse('https://cs308canvas.herokuapp.com/purchase/step1');

    final res = await http.post(
        Uri.http(url.authority, url.path),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
          'Cookie': Global.cookie,
        },
        body: {
          "fullName": customer_info,
          "BaddressCountry": Billing_country,
          "BaddressCity": Billing_city,
          "BaddressStreet":Billing_handstreet,
          "SaddressCountry": Shipping_country,
          "SaddressCity": Shipping_city,
          "SaddressStreet": Shipping_handstreet,
        }, encoding: Encoding.getByName("utf-8"),);
    print(res.statusCode);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("it has workededddd");
      if (res.headers['set-cookie'] != null){
        var myCookie = res.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
        print('after: ');
        print(Global.cookie);

      }
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Order Step1 Successfully Completed!',
          backgroundColor: Colors.black12,
          width: 30,
          borderRadius: 40,
          confirmBtnColor: AppColors.primary,
          onConfirmBtnTap: (){
            Navigator.pushNamed(context, '/payment');
          }
      );

    }
    else if (res.statusCode >= 400 && res.statusCode < 500) {
      print("hello im an error");

    }

    else {
      print(jsonDecode(res.body.toString()).toString());
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: AppColors.textColor,
      elevation: 0.0,
      title: Text("Checkout"),
    ),
    body: Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image(
            image: AssetImage('assets/images/payments.png'),
            height: 200,
          ),
          const SizedBox(height: 10),
          Center(
            child: Text("Order Information", style: TextStyle(
              fontFamily: 'Lexend-Thin',
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            ),
          ),
          Divider(
            height: 30.0,
            //indent: 5.0,
            color: AppColors.textColor,
          ),
          const SizedBox(height: 10),
          buildCustomerName(),
          const SizedBox(height: 18),
          Center(
            child: Text("Billing Address", style: TextStyle(
              fontFamily: 'Lexend-Thin',
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            ),
          ),
          Divider(
            height: 20.0,
            //indent: 5.0,
            color: AppColors.textColor,
          ),
          const SizedBox(height: 16),
          buildBillinghouseandStreet(),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: buildBillingCity(),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: buildBillingcountry(),
            )
          ]),
          const SizedBox(height: 16),
          Center(
            child: Text("Shipping Address", style: TextStyle(
              fontFamily: 'Lexend-Thin',
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            ),
          ),
          Divider(
            height: 30.0,
            //indent: 5.0,
            color: AppColors.textColor,
          ),
          const SizedBox(height: 16),
          buildShippinghouseandStreet(),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: buildShippingCity(),

            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: buildShippingcountry(),
            )
          ]),
          const SizedBox(height: 20),
          Divider(
            height: 20.0,
            //indent: 5.0,
            color: AppColors.textColor,
          ),

          const SizedBox(height: 20),

          buildSubmit(),

        ],
      ),
    ),

  );

  Widget buildCustomerName() => TextFormField(
    //controller: customer_info,
    decoration: InputDecoration(
      labelText: 'Customer Name',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
        border: OutlineInputBorder(),
        errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
        focusedErrorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
        errorStyle: TextStyle(color: AppColors.primary),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0))
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else {
        return null;
      }
    },

    onSaved: (value) => setState(() => customer_info = value),
  );

  //Shipping text fields
  Widget buildShippinghouseandStreet() => TextFormField(
    //controller: Shipping_handstreet,
    decoration: InputDecoration(
      labelText: 'House/Apt Number & Street',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
      errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
      focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
      errorStyle: TextStyle(color: AppColors.primary),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else if(value.length <=5){
        return 'Invalid address';
      }
      else {
        return null;
      }
    },
    //maxLength: 100,
    onSaved: (value) => setState(() => Shipping_handstreet= value),
  );
  Widget buildShippingCity() => TextFormField(
    //controller: Shipping_city,
    decoration: InputDecoration(
      labelText: 'City',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
      errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
      focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
      errorStyle: TextStyle(color: AppColors.primary),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else {
        return null;
      }
    },
    //maxLength: 100,
    //onSaved: (value) => setState(() => Shipping_city.text= value),
    onSaved: (value) => setState(() => Shipping_city= value),
  );
  Widget buildShippingcountry() => TextFormField(
    //controller: Shipping_country,
    decoration: InputDecoration(
      labelText: 'Country',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
       errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
       focusedErrorBorder:
           OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
       errorStyle: TextStyle(color: AppColors.primary),
       focusedBorder:
       OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else {
        return null;
      }
    },
    //maxLength: 30,
    onSaved: (value) => setState(() => Shipping_country= value),
  );

  //billing text fields
  Widget buildBillinghouseandStreet() => TextFormField(
    //controller: Billing_handstreet,
    decoration: InputDecoration(
      labelText: 'House/Apt Number & Street',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
      errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
      focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
      errorStyle: TextStyle(color: AppColors.primary),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else if(value.length <=5){
        return 'Invalid address';
      }
      else {
        return null;
      }
    },
    //maxLength: 100,
    onSaved: (value) => setState(() => Billing_handstreet= value),
  );
  Widget buildBillingCity() => TextFormField(
    //controller: Billing_city,
    decoration: InputDecoration(
      labelText: 'City',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
      errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
      focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
      errorStyle: TextStyle(color: AppColors.primary),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else {
        return null;
      }
    },
    //maxLength: 100,
    onSaved: (value) => setState(() => Billing_city= value),
  );
  Widget buildBillingcountry() => TextFormField(
    //controller: Billing_country,
    decoration: InputDecoration(
      labelText: 'Country',
      labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15,),
      border: OutlineInputBorder(),
      errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor)),
      focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
      errorStyle: TextStyle(color: AppColors.primary),
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
    ),
    validator: (value) {
      if (value.length ==0) {
        return 'This field cannot be empty';
      }
      else {
        return null;
      }
    },
    //maxLength: 30,
    onSaved: (value) => setState(() => Billing_country= value),
  );

  Widget buildSubmit() => Builder(
    builder: (context) => ButtonWidget(
      text: 'Payment Method',
      onClicked: () {
        final isValid = formKey.currentState.validate();
        FocusScope.of(context).unfocus();
        if (isValid) {
          formKey.currentState.save();
          send1();
          //Navigator.pushNamed(context, '/payment');
        }
      },
    ),
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    @required this.text,
    @required this.onClicked,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary) ),
    child: Text(
      text,
      style: TextStyle(fontSize: 24),
    ),
    onPressed: onClicked,
  );
}




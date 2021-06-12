import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';

class carttotal extends StatefulWidget {
  @override
  _carttotalState createState() => _carttotalState();
}

class _carttotalState extends State<carttotal> {
  Future<Map> gettotal() async {
    //replace your restFull API here.
    final url = Uri.parse('https://cs308canvas.herokuapp.com/purchase/totalprice');
    final re = await http.get(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    var body = jsonDecode(re.body);
    //price =body;
    print(re.statusCode);
    if(re.statusCode == 200){
      debugPrint("Total recieved: ${re.body}");
    }else{
      debugPrint("Something went wrong! Status Code is: ${re.statusCode}");
    }
    return body  ;
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: AppColors.textColor,
      elevation: 0.0,
      title: Text("Payment Bill"),
    ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: [
        Image(
          image: AssetImage('assets/images/discount.png'),
          height: 200,
        ),
        const SizedBox(height: 10),
        Center(
          child: Text("Cart Total and Discounts", style: TextStyle(
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
        priceT(),
        SizedBox(height: 20,),
        ElevatedButton(
          onPressed: (){

            CoolAlert.show(
                context: context,
                type: CoolAlertType.confirm,
                text: 'Would you like to Place an Order or Continue Shopping?',
                backgroundColor: Colors.black12,
                width: 30,
                borderRadius: 40,
                confirmBtnText: 'Proceed',
                confirmBtnColor: AppColors.primary,
                //autoCloseDuration: Duration(seconds: 2),
                onConfirmBtnTap: (){
                  Navigator.pushReplacementNamed(context, '/checkout');
                },
                cancelBtnText: 'Continue Shopping',
                onCancelBtnTap:(){
                  Navigator.pushReplacementNamed(context, '/home');
                }

            );

          }, child: Text('Place Order'),
          style: ElevatedButton.styleFrom(
            primary: AppColors.textColor,
            onPrimary: Colors.white,
            onSurface: Colors.grey,
          ),
        )
      ],
    ),

  );
  Widget priceT() {
    return FutureBuilder(
      future: gettotal(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
          return Text(
              'There was an error :('
          );
        }
        else if (projectSnap.connectionState == ConnectionState.done && projectSnap.hasData != null){
          return Card(
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.grey,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.payments_outlined,
                    color: AppColors.textColor,
                    size: 40,
                  ),
                  title: Text(
                    'Receipt',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: AppColors.textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Payment Details',
                    style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
                  ),
                ),
                Text(
                  'Total Price: ${projectSnap.data['totalprice']} TL',
                  style: TextStyle(color: AppColors.textColor.withOpacity(0.8),fontSize: 20,),
                ),
                Text(
                  'Discounted Total : ${projectSnap.data['totalDCprice']} TL',
                  style: TextStyle(color: AppColors.textColor.withOpacity(0.8),fontSize: 20,),
                ),
              ],
            ),
          );
        }
        else{
          return (Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      AppColors.orangelighttone))));
        }
      },
    );
  }
}

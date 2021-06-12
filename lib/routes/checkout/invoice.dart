import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/global/totalPrice.dart';
import 'package:team17_mobile/utils/color.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Invoicetemp extends StatefulWidget {
  @override
  _InvoicetempState createState() => _InvoicetempState();
}
class _InvoicetempState extends State<Invoicetemp> {
  Future<Map> getbill() async {
    final url = Uri.parse(
        'https://cs308canvas.herokuapp.com/purchase/totalprice');
    final response1 = await http.get(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,

      },
    );
    Map data = jsonDecode(response1.body);
    return data;
  }

  Future<Map> getpersonalinfo() async {
    final url = Uri.parse(
        'https://cs308canvas.herokuapp.com/purchase/sendinvoice');
    final respon = await http.get(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    Map invoice = jsonDecode(respon.body);
    return invoice;
  }


  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.textColor,
          elevation: 0.0,
          title: Text("Invoice"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Image(
              image: AssetImage('assets/success.png'),
              height: 200,
            ),
            const SizedBox(height: 30),
            Center(
              child: Text("Order Confirmed", style: TextStyle(
                fontFamily: 'Lexend-Thin',
                fontSize: 30.0,
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
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: AppColors.textColor,
                  size: 30, ),
                SizedBox(width:10 ,),
                Expanded(
                  child: Center(
                    child: Text("Please check your email for an auto-generated invoice!",style: TextStyle(
                      fontFamily: 'Lexend-Thin',
                      fontSize: 18.0,
                      color: AppColors.textColor,
                    ),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            personaldetails(),

            const SizedBox(height: 16),
            Center(
              child: Text("Payment Details", style: TextStyle(
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
            const SizedBox(height: 20),
            priceT(),
            SizedBox(height: 20,),
            ElevatedButton(child: Text('Continue Shopping'),
              style: ElevatedButton.styleFrom(
                primary: AppColors.textColor,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              onPressed: () {
              totalPrice =0;
              Navigator.pushReplacementNamed(context, '/home');
              },)



          ],
        ),
      );

  Widget priceT() {
    return FutureBuilder(
      future: getbill(),
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Text(
              'There was an error :('
          );
        }
        else if(projectSnap.connectionState == ConnectionState.done && projectSnap.hasData != null)
          {
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
                  Column(
                    children: [
                      Row(children: [
                        SizedBox(width: 20,),
                        Expanded(
                          child:   Text(
                            'Total Price:',
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),

                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child:  Text(
                            '${projectSnap.data["totalprice"]} TL',
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                          ),

                        )
                      ]),
                      Row(children: [
                        SizedBox(width: 20,),
                        Expanded(
                          child:   Text(
                            'Discounted Total:',
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child:  Text(
                            '${projectSnap.data["totalDCprice"]} TL',
                            style: TextStyle(
                              color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        )
                      ]),
                    ],
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

  Widget personaldetails() {
    return FutureBuilder(
      future: getpersonalinfo(),
      builder: (context, Snap) {
        if (Snap.connectionState == ConnectionState.none &&
            Snap.hasData == null) {
          return Text(
              'There was an error during inovice loading:('
          );
        }
        else if(Snap.connectionState == ConnectionState.done && Snap.hasData != null)
        {
          return Card(
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.grey,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.assignment_ind_outlined,
                    color: AppColors.textColor,
                    size: 40,
                  ),
                  title: Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: AppColors.textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Order and Customer Information',
                    style: TextStyle(color: AppColors.textColor.withOpacity(0.8)),
                  ),
                ),
                Column(
                  children: [
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        'Customer Name:',
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.8), fontSize: 23,),
                      ),
                    ]),
                    SizedBox( height: 5,),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        '${Snap.data["fullName"]}',
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ]),
                    SizedBox( height: 18,),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        'Billing Address:',
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.8), fontSize: 23,),
                      ),
                    ]),
                    SizedBox( height: 5,),
                    Row(children: [
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                        '${Snap.data["BaddressStreet"]}',
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 2,
                        ),
                      ),
                    ]),
                    Row(children: [
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                            '${Snap.data["BaddressCity"]} , ${Snap.data["BaddressCountry"]} ',
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ]),
                    SizedBox(height: 18),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        'Shipping Address:',
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.8), fontSize: 23,),
                      ),
                    ]),
                    SizedBox( height: 5,),
                    Row(children: [
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          '${Snap.data["SaddressStreet"]}',
                          style: TextStyle(
                            color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                        ),
                      ),
                    ]),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        '${Snap.data["SaddressCity"]} ${Snap.data["SaddressCountry"]} ',
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.8), fontSize: 20,),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ]),
                    SizedBox(height: 18),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        'Order Placed On:',
                        style: TextStyle(
                          color: AppColors.primary.withOpacity(0.8), fontSize: 23, ),
                      ),
                    ]),
                    SizedBox( height: 5,),
                    Row(children: [
                      SizedBox(width: 20,),
                      Text(
                        '${Snap.data["date"].toString().substring(4, 15,)}',
                        style: TextStyle(
                          color: AppColors.textColor.withOpacity(0.9), fontSize: 20,),
                      ),
                    ]),
                    SizedBox(height: 10,)
                  ],
                )
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

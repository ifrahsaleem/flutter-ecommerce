import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/routes/homepage/homePage.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function press;

  const OrderCard({
    Key key,
    this.order,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canCancel = true;
    final splicedDate = order.date.substring(0, order.date.indexOf('T'));
    final date1 = DateTime.parse(order.date);
    final date2 = DateTime.now();
    final difference = date2
        .difference(date1)
        .inDays;
    if (difference > 30 || order.status != 'processing' || order.products.length == 0) {
      canCancel = false;
    }

    Future<void> cancelOrder() async {
      var query = order.orderID;
      final url = Uri.parse(
          'http://cs308canvas.herokuapp.com/purchase/${query}');
      final response1 = await http.delete(
        Uri.http(url.authority, url.path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': Global.cookie,
        },
      );

      if (response1.statusCode == 200) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Order cancelled successfully!',
            backgroundColor: Colors.black12,
            width: 30,
            borderRadius: 40,
            confirmBtnColor: AppColors.primary,
            autoCloseDuration: Duration(seconds: 5),
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            }
        );
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: 'Could not cancel order!',
            backgroundColor: Colors.black12,
            width: 30,
            borderRadius: 40,
            confirmBtnColor: AppColors.primary,
            autoCloseDuration: Duration(seconds: null),
            onConfirmBtnTap: () {
              Navigator.of(context).pop();
            }
        );
      }
    }

    return GestureDetector(
      onTap: press,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.8,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: order.products == null ? null : Image.network(
                        order.products[0].onlineImageLink),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.orderID}',
                      style: TextStyle(
                          color: Colors.grey, fontSize: 12, fontFamily: 'Lexend'),
                      maxLines: 2,
                    ),
                    Text(
                      '${splicedDate}',
                      style: TextStyle(color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Lexend'),
                      maxLines: 2,
                    ),
                    Text(
                      'Status: ${order.status}',
                      style: TextStyle(color: AppColors.textColor,
                          fontSize: 16,
                          fontFamily: 'Lexend'),
                      maxLines: 2,
                    ),
                    // SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "\$"+double.parse(order.total).toStringAsFixed(2).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                      fontFamily: 'Lexend',
                                      fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Visibility(
                          visible: canCancel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                key: UniqueKey(),
                                onPressed: () {
                                  cancelOrder();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(),
                                      ));
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 14.0,
                                    letterSpacing: -0.7,
                                    fontFamily: 'Lexend',
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  side: BorderSide(
                                      width: 2, color: AppColors.orangelighttone),
                                ),
                              )
                            ],
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
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';
import "package:team17_mobile/global/global.dart";

class CheckoutCard extends StatelessWidget {
  
  final double totalPrice;
  const CheckoutCard({
    Key key, this.totalPrice
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> showAlert(String msg) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            //backgroundColor: AppColors.secondary,
            title: Text('Alert!',
              textAlign: TextAlign.justify,
              style:
              TextStyle(color: AppColors.primary, fontSize: 25, height: 1, fontFamily: 'Lexend'),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(msg,
                    textAlign: TextAlign.justify,
                    style:
                    TextStyle(color: AppColors.textColor, fontSize: 18, height: 1, fontFamily: 'Lexend'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('ok!',textAlign: TextAlign.justify,
                  style:
                  TextStyle(color: AppColors.textColor, fontSize: 16, height: 1, fontFamily: 'Lexend'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: AppColors.primary.withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/images/receipt.svg"),
                ),
                Spacer(),
                // Text("Add voucher code"),
                // const SizedBox(width: 10),
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 12,
                //   color: AppColors.orangelighttone,
                // )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      style: TextStyle(
                        fontFamily: 'Lexend-Thin',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                      children: [
                        TextSpan(
                          text: '\$'+(double.parse((totalPrice).toStringAsFixed(2)).toString() == null ? '0' : double.parse((totalPrice).toStringAsFixed(2)).toString()),
                          style: TextStyle(
                            fontFamily: 'Lexend-Thin',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: OutlinedButton(
                    onPressed: () {
                      if(Global.loggedIn == 1 && totalPrice != 0.0) {
                      Navigator.pushNamed(context, '/cartTotal');
                      }
                      else if(Global.loggedIn == 0) {
                      showAlert("You must login first!");
                      }
                      else if(totalPrice == 0.0) {
                        showAlert("Cart is empty! You cannot place an order!");
                      }
                    },
                    child: Text('Check Out', style: kButtonDarkTextStyle),
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
    );
  }
}
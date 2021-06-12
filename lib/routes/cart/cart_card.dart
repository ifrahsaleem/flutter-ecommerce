import 'package:flutter/material.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:team17_mobile/model/cart_model.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    bool _isVisibleDiscount = false;
    if (cart.productDiscount != null){// && searchedProduct.productStock  > 0){
      _isVisibleDiscount = true;
    }
      return Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(cart.productFlutterLink),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.productName,
                  style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lexend'),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible : _isVisibleDiscount,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${cart.productPrice} \$",
                                style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.redAccent,
                                    fontWeight: FontWeight.w400, fontSize: 16, color:Colors.grey, fontFamily: 'Lexend')),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${cart.productDCPrice} \$",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.primary, fontFamily: 'Lexend')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              " x${cart.quantity}",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textColor, fontFamily: 'Lexend')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }

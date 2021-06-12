/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/routes/allproducts/model/products.dart';
import 'package:team17_mobile/routes/allproducts/components/categories.dart';

import 'itemcard.dart';


class Productdisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 5.0),
          child: Text(
            "Products",
            style: kHeadingSmallTextStyle,
          ),
        ),
        Categories(),
        SizedBox(height: 20,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.largeMargin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimen.largeMargin,
                  crossAxisSpacing: Dimen.largeMargin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: products[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {}
                      )),
                )),
          ),
        ),

      ],
    );
  }
}
*/
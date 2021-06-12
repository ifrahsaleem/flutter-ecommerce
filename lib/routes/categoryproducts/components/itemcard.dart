import 'package:flutter/material.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Dimen.largeMargin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.productName}",
                child: Image.network(product.onlineImageLink, fit:BoxFit.scaleDown),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimen.largeMargin / 4),
            child: Text(
              // products is out demo list
              product.productName,
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "\$${product.productPrice}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

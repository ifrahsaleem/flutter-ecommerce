import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/landing/widgets/Discounts.dart';
import 'package:team17_mobile/routes/landing/widgets/Horizotallist.dart';
import 'package:team17_mobile/routes/landing/widgets/bestsellers.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';
import 'package:team17_mobile/routes/landing/widgets/features.dart';
import 'package:team17_mobile/routes/landing/widgets/headrer.dart';
import 'package:team17_mobile/routes/landing/widgets/morebutton.dart';
import 'package:team17_mobile/routes/landing/more_display/morediscounts.dart';
import 'package:team17_mobile/routes/landing/more_display/moreBestSellers.dart';
import 'package:team17_mobile/utils/color.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(

          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWithSearchBox(size: size),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: Center(
                  child: Text(
                    "CATEGORIES",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Container(
                alignment: Alignment.center,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.kBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: AppColors.primary.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: HorizontalList(),
                    ),

                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              TitleWithMoreBtn(title: "BEST SELLERS", press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          moreBestSeller(),
                    )
                );
              }),
              BestSellers(),
              SizedBox(height: kDefaultPadding),
              TitleWithMoreBtn(title: "DISCOUNTS", press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        moreDiscounts(),
                  )
              );
              }
              ),
              Discounts(),
              SizedBox(height: kDefaultPadding),
              Text("   Highest Rated", style:TextStyle(color: AppColors.textColor,fontWeight: FontWeight.bold, fontSize: 21)),
              Featured(),

              SizedBox(height: kDefaultPadding),
        ],
      ),
    ),

      ],
    );
  }
}



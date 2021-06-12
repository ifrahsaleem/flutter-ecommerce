import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';
import 'package:team17_mobile/utils/color.dart';



class TitleWithMoreBtn extends StatelessWidget {
  const TitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),
          ElevatedButton(
            onPressed: press,
            child: Text('More', style:TextStyle(color: AppColors.secondary,) ,),
            style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              onPrimary: AppColors.primary,
              shadowColor: AppColors.primary,
              elevation: 5,
            ),
          )
        ],
      ),
    );
  }
}
/* TextButton(
            child: Text('More'),
            style: TextButton.styleFrom(
              primary: Colors.teal,
            ),
            onPressed: () {
              print('Pressed');
            },
          )*/
class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 2),
              height: 7,
              color: AppColors.primary.withOpacity(0.25),
            ),
          )
        ],
      ),
    );
  }
}
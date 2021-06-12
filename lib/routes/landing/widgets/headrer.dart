import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';
import 'package:team17_mobile/utils/color.dart';



class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1.8),
      height: size.height * 0.23,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            height: size.height * 0.23,
            decoration: BoxDecoration(
              color: AppColors.textColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Welcome to Canvas!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Image.asset('assets/logo101.png', height: 220,)

              ],
            ),
          ),


        ],
      ),

    );
  }
}


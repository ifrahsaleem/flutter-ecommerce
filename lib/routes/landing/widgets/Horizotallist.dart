import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/categoryproducts/displaycategoryproducts.dart';
import 'package:team17_mobile/routes/landing/constantpaddings.dart';
import 'package:team17_mobile/utils/color.dart';

class HorizontalList extends StatelessWidget {
  List<String> name = [
    'Brush',
    'Canvas',
    'Painting',
    'Paint',
    'Spray',
    'Accessory'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_caption: name[0],
          ),

          Category(
            image_caption: name[1],
          ),

          Category(
            image_caption: name[2],
          ),

          Category(
            image_caption: name[3],
          ),

          Category(
            image_caption: name[4],
          ),
          Category(
            image_caption: name[5],
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {

  final String image_caption;

  Category({this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
            DisplayCategoryProducts(value: image_caption),
          );
          Navigator.of(context).push(route);
        },
        child: ClipRRect(
          borderRadius:  BorderRadius.all(Radius.circular(50.0)),
          child: Container(
            color: AppColors.primary,
            width: 120,
            child: ListTile(
                title: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    image_caption,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBackgroundColor),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
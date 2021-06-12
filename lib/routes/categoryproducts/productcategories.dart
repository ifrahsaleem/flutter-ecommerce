import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/categoryproducts/displaycategoryproducts.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/dimension.dart';
import 'package:team17_mobile/utils/styles.dart';
import '../allproducts/components/itemcard.dart';

class Displaycategories extends StatefulWidget {
  @override
  _DisplaycategoriesState createState() => _DisplaycategoriesState();
}

class _DisplaycategoriesState extends State<Displaycategories> {
  List<String> img = [
    'assets/images/brushes.png',
    'assets/images/canvas.png',
    'assets/images/framepainting.png',
    'assets/images/paintshot.png',
    'assets/images/spraypaint3.png',
    'assets/images/easel3.png'
  ];
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Column(
              children: [
                SizedBox(height: 5),
                SizedBox(height: 1),
                Text("Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: 'Lexend')),
                SizedBox(height: 2),
              ],
            ),
            backgroundColor: AppColors.textColor,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GridView.count(
          childAspectRatio: 0.7,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return Center(
              child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset(img[index], fit: BoxFit.fill),
                      ),
                      new GestureDetector(
                        onTap: () {
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new DisplayCategoryProducts(value: name[index]),
                          );
                          Navigator.of(context).push(route);
                        },
                        child: new Text(name[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                fontFamily: 'Lexend')),
                      ),
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }
}

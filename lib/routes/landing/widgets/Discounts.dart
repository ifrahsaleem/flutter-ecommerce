import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/landing/widgets/bestsellers.dart';
import 'package:team17_mobile/routes/landing/landingpage.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Discounts extends StatefulWidget {
  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {

  List<Product> discounted;
  Future<List<Product>> highestrated() async {
    final response = await http.get(
      Uri.http('cs308canvas.herokuapp.com','/product/discounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      discounted = body.map((dynamic item) => Product.fromJson(item)).toList();
      return discounted;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //width: 150,
      child: FutureBuilder(
          future: highestrated() ,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('There was an error');
            }
            else if (snapshot.hasData) {
              return  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(8, 14, 8, 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SingleProduct(id: discounted[index].productId),
                                )
                            );
                          },
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[400],
                                      offset: Offset(-2, -1),
                                      blurRadius: 5),
                                ]),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: discounted[index].onlineImageLink,
                                          height: 190,
                                          width: 190,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height:  10,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${discounted[index].productName} ',
                                                style: TextStyle(
                                                  color: AppColors.primary.withOpacity(0.8), fontSize: 18,),
                                                overflow: TextOverflow.fade,
                                                softWrap: true,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25, right: 8.0 ),
                                              child: Container(
                                                width: 60,
                                                height: 45,
                                                child: Center(
                                                  child: Text(
                                                    '-'+discounted[index].productDiscount.toString()+'\%',
                                                    textScaleFactor: 2,
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 9, color: Colors.white, fontFamily: 'Lexend'),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(color: Colors.red, spreadRadius: 1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10, width: 10,),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text("${discounted[index].productPrice} \$",
                                                      style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.redAccent,
                                                          fontWeight: FontWeight.w400, fontSize: 15, color:Colors.grey, fontFamily: 'Lexend')),
                                                  Text("${discounted[index].productDCPrice} \$",style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: AppColors.primary, fontFamily: 'Lexend')),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  }
                  );
            }
            else{
              return  Loading();
            }
          }
      ),
    );
  }
}




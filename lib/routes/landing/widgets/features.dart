import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/landing/landingpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {

  List<Product> highest_rated;
  Future<List<Product>> highestrated() async {
    final response = await http.get(
      Uri.http('cs308canvas.herokuapp.com','/product/top7'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      highest_rated = body.map((dynamic item) => Product.fromJson(item)).toList();
      return highest_rated;
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
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
                  itemCount:snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(8, 14, 8, 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SingleProduct(id: snapshot.data[index].productId),
                                )
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 150,
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
                                          image:snapshot.data[index].onlineImageLink,
                                          height: 90,
                                          width: 70,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(width: 5,),
                                    Expanded(
                                      child: Text(
                                        '${snapshot.data[index].productName} ',
                                        style: TextStyle(
                                          color: AppColors.primary.withOpacity(0.8), fontSize: 18,),
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: 2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: GestureDetector(
                                        child: Container(),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(width: 5),
                                        Icon(Icons.star, color: Colors.yellow, size: 16,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0),
                                          child: CustomText(text:snapshot.data[index].productRating.toString(), color: Colors.grey, size: 14.0,
                                          ),
                                        ),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: CustomText(text: "\$${snapshot.data[index].productPrice}", weight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SpinKitFadingCircle(color: AppColors.primary, size: 30,)
    );
  }
}


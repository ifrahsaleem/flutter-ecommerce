import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/global/totalPrice.dart';
import 'package:team17_mobile/model/comment.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/singleProduct/counter.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/utils/styles.dart';
import 'package:cool_alert/cool_alert.dart';

class SingleProduct extends StatefulWidget {
  final String id;
  SingleProduct({Key key, this.id}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {

  Product searchedProduct;
  String query = "";
  String query1 = "";
  final numberOfItems = Counter();
  Future<Product> getProduct() async {
    query = widget.id;
    print(widget.id);
    final url = Uri.parse('http://cs308canvas.herokuapp.com/product/allinfo/${query}');
    final response1 = await http.get(

      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response1.statusCode == 200) {
      Map<String, dynamic> jsonMap= json.decode(response1.body);
      searchedProduct =   Product.fromJson(jsonMap);
      await getComments(query);
      return searchedProduct;
    } else {
      throw Exception('Failed to load data'); //TODO: add alert
    }
  }
  List<Comment> comments;
  Future<List<Comment>> getComments(String query) async {
    final url = Uri.parse('http://cs308canvas.herokuapp.com/comment/${query}');
    final res = await http.get(

      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    print("the sat: ");
    print(res.statusCode);
    if (res.statusCode == 200) {
      List<dynamic> bdy = jsonDecode(res.body);
      comments = bdy.map((dynamic item) => Comment.fromJson(item)).toList();
      print(comments.length);
      if (comments == null)
        comments = [];
      return comments;
    } else {
      throw Exception('Failed to load data');
    }
  }
  //final snackBar = SnackBar(content: Text('Successfully added to cart!'));

  Future<void> addToCart() async {
    final url1 = Uri.parse('https://cs308canvas.herokuapp.com/cart/add/${query}/${numberOfItems.value}');
    var body = {
      'productid': query,
      'quantity': (numberOfItems.value).toString(),
    };
    final response = await http.post(
      Uri.http(url1.authority, url1.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        'Cookie': Global.cookie,
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 200) {
      if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
        //TipDialogHelper.success("Success!");
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Added to cart successfully!',
          backgroundColor: Colors.black12,
          width: 30,
          borderRadius: 40,
          confirmBtnColor: AppColors.primary,
          autoCloseDuration: Duration(seconds: 2),
          onConfirmBtnTap: (){
            Navigator.of(context).pop();
          }
      );
      totalPrice += double.parse((searchedProduct.productDCPrice*numberOfItems.value).toStringAsFixed(2));

    } else if (response.statusCode == 400) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Reached maximum quantity!",
        backgroundColor:Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 4),
      );
    }else{
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Couldn't add to cart!",
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 3),
      );

    }
  }

 // var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(data));

  @override
  void initState() {
    // Assign that variable your Future.
    getProduct();
    getComments(widget.id);
    numberOfItems.value = 0;
    super.initState();
  }


  var isFavourite = false;
  //int numberOfItems = 0;
  bool _isBestSelling = false;
  String quantity = "", bestSeller = "";
  String psize = "";
  double ratingss = 0;
  var strings =  [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            title: Text(
              "Product Details",
              style: kAppBarTitleTextStyle,
            ),
            backgroundColor: AppColors.textColor,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 30.0,),
              onPressed: () => Navigator.of(context).pop(),
            ),


          )
      ),
      body: FutureBuilder(
        future: getProduct(),
        builder: (context, snapshot){
          if (snapshot.hasError) {
            return Text(
                'There was an error :('
            );
          }
          else if (snapshot.hasData){

            if (comments == null){
              comments = [];
            }
            if (searchedProduct.productStock == 0){
              quantity = "OUT OF STOCK";
            }else
            {
              quantity = "${searchedProduct.productStock}";
            }

            if (searchedProduct.productNumofRatings == 0)
              ratingss = 0;
            else
              ratingss = (searchedProduct.productRating).toDouble();

            if (searchedProduct.productSize == null)
              psize = "STD";
            else
              psize = searchedProduct.productSize.toString();
            if (searchedProduct.productBestseller == true){
              _isBestSelling = true;
               bestSeller = "Best-Selling Product";
            }
            print(snapshot.data);
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Stack(
                      children: <Widget>[
                        ProductTitleWithImage(),
                        Container(
                          margin: EdgeInsets.only(top: 410),
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          // height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            border: Border.all(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Visibility(
                                    visible: _isBestSelling,
                                    child: Row(
                                      children: [
                                        Icon(Icons.star_rate_rounded, color: AppColors.primary, size: 20),
                                        Text(
                                          bestSeller,
                                          textAlign: TextAlign.justify,
                                          style:
                                          TextStyle(color: AppColors.primary, fontSize: 13, height: 1, fontFamily: 'Lexend'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              DistributorSizeAndStock(),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: AppColors.textColor, fontFamily: 'Lexend'),
                                        children: [
                                          TextSpan(text: "Category:  ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3
                                                .copyWith(color: AppColors.textColor,fontWeight: FontWeight.w600, fontSize: 18,fontFamily: 'Lexend' ),
                                          ),
                                          TextSpan(
                                            text:  searchedProduct.productCategory,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Lexend'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: RatingBar.builder(
                                      wrapAlignment: WrapAlignment.start,
                                      glowColor: Colors.black,
                                      glowRadius: 20,
                                      itemSize: 20,
                                      initialRating: ratingss.toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      // itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star_rate_rounded,
                                        color: Colors.orangeAccent,//Colors.amber,
                                        size: 1.0,
                                      ),
                                      // onRatingUpdate: (rating) {
                                      //   print(rating);
                                      // },
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 1),
                              Description(),
                              SizedBox(height:1),
                              CounterWithFavBtn(),
                              SizedBox(height: 1),
                              AddToCCart(),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    "${comments.length} people commented on this product",
                                    textAlign: TextAlign.justify,
                                    style:
                                    TextStyle(color: AppColors.primary, fontSize: 16, height: 1, fontFamily: 'Lexend'),
                                  ),
                                ],
                              ),
                              displayComments(),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            );
          }
          else {
            print(snapshot.data);
            return (
                Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.orangelighttone)
                    )
                )
            );
          }
        },
      ),
    );
  }

  Widget ProductTitleWithImage(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              searchedProduct.productName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: AppColors.primary,
                fontFamily: 'Lexend')),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: "${searchedProduct.productId}",
                  child: Image.network(
                    searchedProduct.onlineImageLink,
                    height: 320,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget AddToCCart(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primary,
              ),
            ),
            child: IconButton(
              icon:Icon(Icons.add_shopping_cart),
              iconSize: 35.0,
              color: AppColors.primary,
              onPressed: () {
                //AddToCart.addToCart(query, numberOfItems);
                if (numberOfItems.value > 0){
                  if (numberOfItems.value <= searchedProduct.productStock){
                    addToCart();


                  }else{
                    showAlert("Cannot add ${numberOfItems.value}");
                  }
                }else{
                  showAlert("Cannot add 0 items!");
                }
              },
              tooltip: "Add",
            )
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: AppColors.textColor,
                onPressed: () {
                      Navigator.pushReplacementNamed(context, '/cart');
                },
                child: Text(
                  "Go to Cart".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CounterWithFavBtn(){
    bool _isVisibleDiscount = false;
    if (searchedProduct.productDiscount != null){
      if (searchedProduct.productDiscount  > 0){
        _isVisibleDiscount = true;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _shoppingItem(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: _isVisibleDiscount,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25, right: 8.0 ),
                  child: Container(
                    width: 60,
                    height: 45,
                    child: Center(

                      child: Text(
                        '-'+searchedProduct.productDiscount.toString()+'\%',
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 9, color: Colors.white, fontFamily: 'Lexend'),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 1,
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
              ),
               SizedBox(height: 10, width: 10,),
               Container(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible : _isVisibleDiscount,
                      child: Text((searchedProduct.productPrice).toStringAsFixed(2)+"\$",
                          style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.redAccent,
                                            fontWeight: FontWeight.w400, fontSize: 22, color:Colors.grey, fontFamily: 'Lexend'),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        maxLines: 1,
                      ),

                    ),
                    Text(searchedProduct.productDCPrice.toStringAsFixed(2) +"\$",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: AppColors.primary, fontFamily: 'Lexend'),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      maxLines: 1,),
                  ],
              ),
               ),
            ],

          ),
        ),
      ],
    );
  }
  Widget Description(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        searchedProduct.productDescription,
        style: TextStyle(height: 1.5, fontSize: 16),
      ),
    );
  }

  Widget DistributorSizeAndStock(){
    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: AppColors.textColor, fontFamily: 'Lexend'),
              children: [
                TextSpan(text: "Distributor\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: AppColors.textColor,fontWeight: FontWeight.w600, fontSize: 18,fontFamily: 'Lexend' ),
                ),
                TextSpan(
                  text:  searchedProduct.productDistributor,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Lexend'),
                )
              ],
            ),
          ),
        ),

        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: AppColors.textColor, fontFamily: 'Lexend'),
              children: [
                TextSpan(text: "   Size\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: AppColors.textColor,fontWeight: FontWeight.w600, fontSize: 18,fontFamily: 'Lexend' ),
                ),
                TextSpan(
                  text: "    "+psize,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Lexend'),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: AppColors.textColor, fontFamily: 'Lexend'),
              children: [
                TextSpan(text: "Stock\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: AppColors.textColor,fontWeight: FontWeight.w600, fontSize: 18,fontFamily: 'Lexend' ),
                ),
                TextSpan(
                  text:  "$quantity",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Lexend'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _shoppingItem() {
    return Container(
      height: 40,
      width: 150,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _decrementButton(),
                Text(
                  '${numberOfItems.value}',
                  style: TextStyle(fontSize: 17.0),
                ),
                _incrementButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAlert(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: AppColors.secondary,
          title: Text('Alert!',
            textAlign: TextAlign.justify,
            style:
            TextStyle(color: AppColors.primary, fontSize: 25, height: 1, fontFamily: 'Lexend'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg,
                  textAlign: TextAlign.justify,
                  style:
                  TextStyle(color: AppColors.textColor, fontSize: 18, height: 1, fontFamily: 'Lexend'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('okk',textAlign: TextAlign.justify,
                style:
                TextStyle(color: AppColors.textColor, fontSize: 16, height: 1, fontFamily: 'Lexend'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget _incrementButton() {
    return FloatingActionButton(
      heroTag: "incr",
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          if(numberOfItems.value < searchedProduct.productStock)
            numberOfItems.increment();
        });
      },
    );
  }

  Widget _decrementButton() {
    return FloatingActionButton(
      heroTag: "incr2",
      onPressed: () {
        setState(() {
          if(numberOfItems.value > 0)
            numberOfItems.decrement();
        });
      },
      child: Icon(Icons.remove, color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }


  Widget displayComments() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child:
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: AppColors.lightbluetone,
                  child: ListTile(
                    leading: RatingBar.builder(
                        wrapAlignment: WrapAlignment.start,
                        glowColor: Colors.black,
                        glowRadius: 20,
                        itemSize: 20,
                        initialRating: comments[index].rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_rate_rounded,
                          color: Colors.orangeAccent,//Colors.amber,
                          size: 1.0,
                        )
                    ),
                    title: Text( comments[index].commentContent)
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

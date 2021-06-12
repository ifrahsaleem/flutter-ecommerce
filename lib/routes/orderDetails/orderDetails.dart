import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/model/refund_model.dart';
import 'package:team17_mobile/routes/commentsratings/addCommentsRatings.dart';
import 'package:team17_mobile/routes/orderDetails/constants.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/utils/styles.dart';


class OrderDetails extends StatefulWidget {
  final String orderId;
  OrderDetails({Key key, this.orderId}) : super(key: key);

  @override
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  List<Order> orderList;
  List<Refund> refundList;
  Order myOrder;
  Product pr;
  Refund myRefund = Refund(approved: true, refundId:  "No_refunded/cancelled_items");
  int len = 1, ordLen = 1; double refundTotal = 0, totalOrder = 0.0;
  String query = "";
  List<Product> orderProducts;
  bool _isRefunded = false, _isDelivered = false, _isProcessing = false, _isCancelled = false;
  Future<Order> getOrder() async {
    query = widget.orderId;//"6092e5bca12d61612c393abf";// widget.orderId;
    print(query);
    final url = Uri.parse('http://cs308canvas.herokuapp.com/purchase/${query}');
    final response12 = await http.get(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    print(response12.statusCode);
    if (response12.statusCode == 200) {
      print("whyyy");
      List<dynamic> body12 = jsonDecode(response12.body);
      orderList =  body12.map((dynamic item) => Order.fromJson(item)).toList();
      myOrder = orderList[0];
      if(myOrder.products != null)
        ordLen = myOrder.products.length;
      await getRefunds(query);
      return myOrder;

    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Refund>> getRefunds(String query) async {
    final url = Uri.parse('http://cs308canvas.herokuapp.com/purchase/refunds/${query}');
    final response = await http.get(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      refundList =  body.map((dynamic item) => Refund.fromJson(item)).toList();
      print("ajkdhajf");
      //print(refundList[0].product.productName);
      len = refundList.length;
      if(len == 0){
        refundList = [myRefund];
      }
      print(refundList.length);
      return refundList;
    } else{
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Error!",
        backgroundColor:Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 4),
      );
    }
  }

   Future<void> cancelItem(String prID, String qnt) async {
    query = widget.orderId;//"6092e5bca12d61612c393abf";// widget.orderId;
    final url = Uri.parse('http://cs308canvas.herokuapp.com/purchase/${query}/${prID}/${qnt}');
    final response1 = await http.delete(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    print(response1.statusCode);

    if (response1.statusCode == 200) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Successful",
        backgroundColor:Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 3),

      );
      Timer(Duration(seconds: 3), () => Navigator.of(context).pop());

    } else if (response1.statusCode == 400) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "30 days has passed!\n You can't return the product!",
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
        text: "Error!",
        backgroundColor:Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 4),
      );
    }
  }
  @override
  void initState() {
    // Assign that variable your Future.
    getOrder();
    getRefunds(widget.orderId);

    if(refundList == null){
      len = 0;
    }else{
      len = refundList.length;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40), //work on size
          child: AppBar(
            title: Text(
              "Order details",
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
          future: getOrder(),//Future.wait([getOrder(), getRefunds()]),
            builder: (context, snapshot)//AsyncSnapshot<List<dynamic>> snapshot)
            {
            //print(snapshot.data[0]);
           if (snapshot.hasError) {
              return Text(
                  'There was an error :('
              );
            }
              if (snapshot.hasData){
              //print(snapshot.data[0]);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                   invoiceHeader(),
                    order_body(),
                  ],
                ),
              );
            }
            else {
              //print(snapshot.data[0]);
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

  Widget invoiceHeader() {
    return Container(
      width: ScreenConfig.deviceWidth,
      height: ScreenConfig.getProportionalHeight(374),
      color: AppColors.textColor,

      padding: EdgeInsets.only(
          top: ScreenConfig.getProportionalHeight(70),
          left: ScreenConfig.getProportionalWidth(40),
          right: ScreenConfig.getProportionalWidth(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myOrder.date.toString().substring(0, 10),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: ScreenConfig.getProportionalHeight(40)),
              ),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(10),
              ),
              topHeaderText('#'+myOrder.orderID),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(10),
              ),
              // TODO: form get actual date and format it accondingly
            ],
          ),
          SizedBox(
            height: ScreenConfig.getProportionalHeight(12),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primary,
                    size: ScreenConfig.getProportionalHeight(100),
                  ),
                  addressColumn()
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  SizedBox addressColumn() {
    return
    SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Delivery address",
            style: kButtonDarkTextStyle,
          ),
          SizedBox(
            height: ScreenConfig.getProportionalHeight(10),
          ),
          Container(
            width: ScreenConfig.getProportionalWidth(350),
            child: Text(
              myOrder.address,
              textAlign: TextAlign.right,
              style: korderTextStyle,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 2,
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(myOrder.city+", ",
                style:korderTextStyle,),
              Text(myOrder.country,
                style:korderTextStyle,),
            ],
          ),
        ],
      ),
    );
  }
  Text topHeaderText(String label) {
    return Text(label,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: ScreenConfig.getProportionalHeight(22)));
  }

  Widget order_body(){

      if (myOrder.status.toLowerCase().contains('processing'))
        _isProcessing = true;
      else if (myOrder.status.toLowerCase().contains('cancelled'))
        _isCancelled = true;
      else if (myOrder.status.toLowerCase().contains('in-transit'))
        _isProcessing = true;
      else if (myOrder.status.toLowerCase().contains('delivered'))
        _isDelivered = true;
      else if (myOrder.status.toLowerCase().contains('refund'))
        _isRefunded = true;
      else
        _isProcessing = true;

      //TODO: update visibility conditions
      double height = ScreenConfig.deviceHeight - ScreenConfig.getProportionalHeight(300);
      return Container(
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenConfig.getProportionalWidth(40)),
        color: Color(0xFFF9FCFF),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenConfig.getProportionalHeight(27),
              ),
              orderStatus(),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(40),
              ),
              Column(
                  children: List.generate(
                    myOrder.products.length, //TODO: Products list's length
                        (index) => Column(
                      children: [
                        orderItem(
                          myOrder.products[index].productId,
                          myOrder.products[index].productName,
                            myOrder.products[index].productSize,
                            myOrder.products[index].quantity,
                            myOrder.products[index].onlineImageLink,
                            myOrder.products[index].PriceatPurchase * 1.0,
                        ),
                      ],
                    ),
                  )),


              SizedBox(
                height: ScreenConfig.getProportionalHeight(10),
              ),
              Visibility(
                visible: (len > 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Cancelled/Refunded items: ',
                      style: TextStyle( color: AppColors.textColor,//Colors.black.withOpacity(0.6),
                      fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              Visibility(
                visible: (refundList[0].refundId != "No_refunded/cancelled_items"),
                child: Column(
                    children: List.generate(
                      len, //TODO: Products list's length
                          (index) => Column(
                        children: [
                          refundItem(
                            refundList[index].approved,
                            refundList[index].product.productId,
                            refundList[index].product.productName,
                            refundList[index].product.productSize,
                            refundList[index].quantity,
                            refundList[index].product.onlineImageLink,
                            //44.4,
                            refundList[index].priceAtPurchase * 1.0,
                          ),
                          SizedBox(
                            height: ScreenConfig.getProportionalHeight(24),
                          )
                        ],
                      ),
                    )),
              ),
              orderTotal(double.parse(myOrder.total).toStringAsFixed(2).toString(), "Total:"),
              Visibility(
                  visible: (refundList[0].refundId != "No_refunded/cancelled_items"),
                  child: orderTotal(refundTotal.toStringAsFixed(2).toString(), "Refunded:  ")),
              // (refundTotal > 0 ? ("\$"+refundTotal.toStringAsFixed(2).toString()): 'processing'), //TODO: add refunded money

              SizedBox(
                height: ScreenConfig.getProportionalHeight(15),
              ),
              //orderTotal(double.parse(myOrder.total).toStringAsFixed(2).toString()),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(20),
              ),

             // cancelButton(_isProcessing, _isRefunded, _isDelivered, 21, 28, "order"),
            ],
          ),
        ),
      );
    }
  Row orderTotal(String totalAmount, String msg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(
              msg,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenConfig.getProportionalHeight(32)),
            ),
            SizedBox(
              width: ScreenConfig.getProportionalWidth(50),
            ),
            Text(
              "\$"+ double.parse(totalAmount).toStringAsFixed(2).toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenConfig.getProportionalHeight(32)),
            )
          ],
        )
      ],
    );
  }

  Visibility orderItem(String prID, String prName,String size,
      int quantity, String imagePath, double price) {
    double totalValue = quantity * price;
    totalOrder += totalValue;
    return Visibility(
      visible: (quantity > 0),

      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4) ,
        height: ScreenConfig.getProportionalHeight(200),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenConfig.getProportionalWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 11),
                  blurRadius: 11,
                  color: Colors.black.withOpacity(0.06))
            ],
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenConfig.getProportionalWidth(100),
                  child: Text(
                    prName,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                Image.network(
                  imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Size: "+size,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 13),
                      ),
                      Text(
                        quantity.toString() + "x "+ "\$$price" + " = "+ "\$" + totalValue.toStringAsFixed(2).toString(),
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          icon:Icon(Icons.comment),
                          iconSize: 25.0,
                          color: AppColors.primary,
                          onPressed: (){
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddCommentsRatings(id: prID),
                                ));
                          }),
                      ),
                      Text('Comment', style: TextStyle( color: Colors.black.withOpacity(0.6),
                          fontSize: 11)),
                    ],
                ),
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: Container(
                      height: 23,
                      width: 120,
                      child: cancelButton(prID, quantity, _isProcessing, _isRefunded, _isDelivered, 13, 20, "")
                  ),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }

  Row orderStatus() {
    return Row(
      children: [
        Text("Order Status: ",
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenConfig.getProportionalHeight(30))),
        SizedBox(
          width: ScreenConfig.getProportionalWidth(30),
        ),
        Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                myOrder.status,
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 8, color: AppColors.textColor, fontFamily: 'Lexend'),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            border: Border.all(
              color: AppColors.lightBlue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),

      ],
    );
  }

  Widget cancelButton(String prId, int qnt, bool _isProcessing,bool _isRefunded, bool _isDelivered, double iconSize, int font_size, String cont){
    return Visibility(
      visible: (!_isRefunded && !_isCancelled),
      // ignore: deprecated_member_use
      child: FlatButton(
        color: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          height: ScreenConfig.getProportionalHeight(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel_outlined, color: Colors.white, size: iconSize,),
              SizedBox(
                width: ScreenConfig.getProportionalWidth(21),
              ),
              Visibility(
                visible: _isProcessing,
                child: Text(
                  "Cancel "+cont,
                  style: TextStyle(
                      fontSize: ScreenConfig.getProportionalHeight(font_size),
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Visibility(
                visible: _isDelivered,
                child: Text(
                  "Refund",
                  style: TextStyle(
                      fontSize: ScreenConfig.getProportionalHeight(font_size),
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onPressed: () async {
          var _message = 0;
          CoolAlert.show(
            context: context,
            type: CoolAlertType.custom,
            barrierDismissible: true,
            confirmBtnText: 'Save',
            widget: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter the quantity please',
                prefixIcon: Icon(
                  Icons.confirmation_num,
                ),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              onChanged: (value) => _message = int.parse(value),
            ),
            onConfirmBtnTap: () async {
              print(_message);
              if (_message > qnt || _message< 1 ) {
                await CoolAlert.show(
                  context: context,
                  type: CoolAlertType.error,
                  text:  'Quantity should be greater than 0 and less or equal to '+qnt.toString(),
                );
                return;
              }
              Navigator.pop(context);
              await Future.delayed(Duration(milliseconds: 1000));
              cancelItem(prId, _message.toString());

            },
          );


          //Timer(Duration(seconds: 4), () => Navigator.of(context).pop());
        },
      ),
    );
  }

  Container refundItem(bool approved, String prID, String prName,String size,
      int quantity, String imagePath, double price) {
    double totalValue = quantity * price;
    refundTotal += (approved == true ? totalValue: 0);
    return Container(
      height: ScreenConfig.getProportionalHeight(220),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getProportionalWidth(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 11),
                blurRadius: 11,
                color: Colors.black.withOpacity(0.06))
          ],
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [Text(
                "Refund Status: " + (approved.toString() ==  'false' ? 'processing': 'refunded'),
                style: TextStyle(color: AppColors.primary, fontSize: 16),
              ),]
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ScreenConfig.getProportionalWidth(100),
                child: Text(
                  prName,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Image.network(
                imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Size: "+size,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 13),
                    ),
                    Text(
                      quantity.toString() + "x "+ "\$$price" + " = "+ "\$" + totalValue.toStringAsFixed(2).toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                        icon:Icon(Icons.comment),
                        iconSize: 25.0,
                        color: AppColors.primary,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddCommentsRatings(id: prID),
                              ));
                        }),
                  ),
                  Text('Comment', style: TextStyle( color: Colors.black.withOpacity(0.6),
                      fontSize: 11)),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }

}

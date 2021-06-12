import 'dart:async';
import 'package:team17_mobile/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/model/refund_model.dart';
import 'dart:convert';

class refundApi {
  List<Refund> refundList;
  int len = 1;
  Refund myRefund = Refund(approved: true, refundId:  "No_refunded/cancelled_items");
  Future<List<Refund>> getRefunds(String query) async {
    final url = Uri.parse(
        'http://cs308canvas.herokuapp.com/purchase/refunds/${query}');
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
      refundList = body.map((dynamic item) => Refund.fromJson(item)).toList();
      //print(refundList[0].product.productName);
      len = refundList.length;
      if (len == 0) {
        refundList = [myRefund];
      }
      print(refundList.length);
      return refundList;
    } else {
        throw Exception('Failed to load data');
    }
  }
}
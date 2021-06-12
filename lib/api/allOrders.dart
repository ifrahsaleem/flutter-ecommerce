import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class allOrdersAPI {
  List<Order> orders = [];
  String value = "";
  Future<List<Order>> getorder() async {
    final response1 = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/purchase'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie

      },
    );
    if (response1.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body);
      orders = body1.map((dynamic item) => Order.fromJson(item)).toList();
      //print(products.length);
      return orders;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
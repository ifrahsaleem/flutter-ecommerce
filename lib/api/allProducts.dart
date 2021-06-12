import 'package:team17_mobile/model/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class allProductsAPI {
  List<Product> products = [];
  String value = "";
  Future<List<Product>> getinorder(String order) async {
    var query = {'order': value};
    final response1 = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/product/filter', query),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response1.statusCode == 200) {
      List<dynamic> body1 = jsonDecode(response1.body);
      products = body1.map((dynamic item) => Product.fromJson(item)).toList();
      //print(products.length);
      return products;
    } else {
      throw Exception('Failed to load data');
    }
  }
}


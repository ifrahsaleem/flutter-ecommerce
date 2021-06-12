import 'dart:convert';
import 'package:team17_mobile/model/products.dart';
import 'package:http/http.dart' as http;

class SearchApi {
    static Future<List<Product>> getProducts(String query) async {
    var query1 ={ 'searchString': query};
    final response = await http.get(
      Uri.http('cs308canvas.herokuapp.com', '/product/filter', query1),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic>products = json.decode(response.body);

      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}

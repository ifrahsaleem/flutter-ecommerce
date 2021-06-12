import 'dart:async';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/model/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class commentApi{
   List<Comment> comments = [];
   Future<List<Comment>> getComments(String q) async {
    final url = Uri.parse('http://cs308canvas.herokuapp.com/comment/$q');
    final res = await http.get(

      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': Global.cookie,
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> bdy = jsonDecode(res.body);
     comments=  bdy.map((dynamic item) => Comment.fromJson(item)).toList();
     return comments;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
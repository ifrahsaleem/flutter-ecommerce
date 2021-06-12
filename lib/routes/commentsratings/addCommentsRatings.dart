import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:team17_mobile/global/global.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:team17_mobile/utils/styles.dart';
import 'package:cool_alert/cool_alert.dart';

class AddCommentsRatings extends StatefulWidget {
  final String id;
  AddCommentsRatings({Key key, this.id}) : super(key: key);
  @override
  _AddCommentsRatingsState createState() => _AddCommentsRatingsState();

}


class _AddCommentsRatingsState extends State<AddCommentsRatings> {

  // final String approved = 'false';
  String content = "";
  String rating = '0';

  final _formKey = GlobalKey<FormState>();

  Future<void> addReview() async {
    final url = Uri.parse('https://cs308canvas.herokuapp.com/comment/${widget.id}');
    var body = {
      'content': content,
      // 'approved': approved,
      'rating': rating,
    };
  print(json.encode(body));
    Map<String, dynamic> map = {
      'content': content,
      // 'approved': approved,
      'rating': rating
    };

    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': Global.cookie,
      },
      body: jsonEncode(<String, String>{
        'content': content,
        // 'approved': approved,
        'rating': rating
      }),
    );
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      //successful transmission
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Thank you for your time! Our team will review this shortly!',
          backgroundColor: Colors.black12,
          width: 30,
          borderRadius: 40,
          confirmBtnColor: AppColors.primary,
          autoCloseDuration: Duration(seconds: 5),
          onConfirmBtnTap: (){
            Navigator.of(context).pop();
          }
      );

      if (response.headers['set-cookie'] != null){
        var myCookie = response.headers['set-cookie'];
        Global.cookie = myCookie.substring(0, myCookie.indexOf(';'));
      }

    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Couldn't add review!",
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 5),
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: "Unrecognized response!",
        backgroundColor: Colors.black12,
        width: 30,
        borderRadius: 40,
        confirmBtnColor: AppColors.primary,
        autoCloseDuration: Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Review',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.textColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
          key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
              TextFormField(
                maxLines: 10,
                autofocus: true,
              decoration: InputDecoration(
                hintText: 'Add your review!',
                labelStyle: TextStyle(color: AppColors.textColor, fontSize: 15, fontFamily: 'Lexend'),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor, width: 3.0)),
                errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor, width: 3.0)),
                focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width: 3.0)),
                errorStyle: TextStyle(color: AppColors.primary),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: AppColors.textColor,width:3.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your review!';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => content = value),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    wrapAlignment: WrapAlignment.center,
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.primary,//Colors.amber,
                      size: 1.0,
                    ),
                    onRatingUpdate: (ratings) {
                     rating = ratings.toString();
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                    final isValid = _formKey.currentState.validate();
                    FocusScope.of(context).unfocus();
                    if (isValid) {
                      _formKey.currentState.save();
                      addReview();
                      //Navigator.pushNamed(context, '/payment');
                    }
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Confirm',
                    style: kButtonDarkTextStyle,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
            ],
        )
      )
    );
  }
}
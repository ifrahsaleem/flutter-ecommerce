import 'package:team17_mobile/routes/allorders/allorders.dart';
import 'package:team17_mobile/routes/allproducts/productsTab.dart';
import 'package:team17_mobile/routes/checkout/invoice.dart';
import 'package:team17_mobile/routes/commentsratings/addCommentsRatings.dart';
import 'package:team17_mobile/routes/orderDetails/orderDetails.dart';
import 'package:team17_mobile/routes/signup/authentication.dart';
import 'package:team17_mobile/routes/homepage/homePage.dart';
import 'package:team17_mobile/routes/signup/signup.dart';
import 'package:team17_mobile/routes/signup/signedup.dart';
import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/checkout/checkout.dart';
import 'package:team17_mobile/routes/checkout/paymentpage.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/routes/splashPage/splashpage.dart';
import 'package:team17_mobile/routes/signin/login.dart';
import 'package:team17_mobile/routes/categoryproducts/displaycategoryproducts.dart';
import 'package:team17_mobile/routes/welcome/welcome.dart';
import 'routes/signup/signedup.dart';
import 'routes/signin/login.dart';
import 'routes/signup/signup.dart';
import 'routes/categoryproducts/productcategories.dart';
import 'package:team17_mobile/routes/cart/cart.dart';
import 'routes/checkout/cart_total.dart';

void main() => runApp(MaterialApp(

      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => Welcome(),
        '/signup': (context) => SignUp(),
        '/confirmpasscode': (context) => Confirmation(),
        '/authentication': (context) => Authentication(),
        '/login': (context) => Login(),
        '/singleproduct': (context) => SingleProduct(),
        '/displayallproducts': (context) => Displayproducts(),
        '/displaycategoryproducts': (context) => DisplayCategoryProducts(),
        '/productcategories': (context) => Displaycategories(),
        '/home': (context) =>  HomePage(),
        '/cart': (context) => CartScreen(),
        '/payment': (context) => CreditCardPage(),
        '/checkout': (context) => MainPage(),
        '/productsTab': (context) => Displayproducts(),
        '/invoice': (context) => Invoicetemp(),
        '/allorders' : (content) => AllOrdersScreen(),
        '/addcommentsrating' : (content) => AddCommentsRatings(),
        '/cartTotal': (context) => carttotal(),
         '/orderDetails': (context) => OrderDetails(),
        // '/': (context) => Displaycategories(),
      },
    ));


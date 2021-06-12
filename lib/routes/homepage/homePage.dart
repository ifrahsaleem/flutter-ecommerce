import 'package:flutter/material.dart';
import 'package:team17_mobile/routes/allorders/allorders.dart';
import 'package:team17_mobile/routes/allproducts/productsTab.dart';
import 'package:team17_mobile/routes/cart/cart.dart';
import 'package:team17_mobile/routes/categoryproducts/productcategories.dart';
import 'package:team17_mobile/routes/landing/landingpage.dart';
import 'package:team17_mobile/routes/orderDetails/orderDetails.dart';
import 'package:team17_mobile/routes/search/searchNew.dart';
import 'package:team17_mobile/routes/signin/dummy.dart';
import 'package:team17_mobile/utils/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,decorationColor: Colors.white);
  final List<Widget> _children = [
    Landing(),
    Displayproducts(),

    searchProduct(),
    //Search1(),
    CartScreen(),

  ];
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: AllProducts',
      style: optionStyle,
    ),

    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Cart',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: AppColors.textColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
            backgroundColor: AppColors.textColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: AppColors.textColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: AppColors.textColor,
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,

      ),
    );
  }
}


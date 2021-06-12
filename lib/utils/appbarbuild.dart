/*import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:team17_mobile/utils/color.dart';

class appBarBuild extends StatefulWidget {
  @override
  _appBarBuild createState() => _appBarBuild();
}

class _appBarBuild extends  StatefulWidget {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Canvas'),
        centerTitle: true,
        backgroundColor: AppColors.textColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30.0,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          searchBar.getSearchAction(context),
          IconButton(
            icon:Icon(Icons.shopping_cart),
            iconSize: 25.0,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(width: 10.0)
        ]);
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _appBarBuild() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,

        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: searchBar.build(context),
        key: _scaffoldKey,
        body: new Center(
            child: new Text("Don't look at me! Press the search button!")),
      );
    }
}*/
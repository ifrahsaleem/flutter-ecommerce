import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:team17_mobile/api/search_api.dart';
import 'package:team17_mobile/routes/allproducts/components/itemcard.dart';
import 'package:team17_mobile/model/products.dart';
import 'package:team17_mobile/routes/drawer/drawer.dart';
import 'package:team17_mobile/routes/search/search_widget.dart';
import 'package:team17_mobile/routes/singleProduct/singleProd.dart';
import 'package:team17_mobile/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:team17_mobile/utils/dimension.dart';

class searchProduct extends StatefulWidget {
  @override
  searchProductState createState() => searchProductState();
}

class searchProductState extends State<searchProduct> {
  List<Product> products = [];
  String query = '';
  Timer debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    products = await SearchApi.getProducts(query);

    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Products"),
      centerTitle: true,
      backgroundColor: AppColors.textColor,
    ),
    drawer: buildDrawer(context),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Dimen.largeMargin,
                crossAxisSpacing: Dimen.largeMargin,
                childAspectRatio: 0.75,
              ),
              itemBuilder:
                //final product = products[index];

                //return buildProduct(product);
                  (context, index) => ItemCard(
                product: products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleProduct(id: products[index].productId),
                    )),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Name or category ...',
    onChanged: searchProduct,
  );

  Future searchProduct(String query) async => debounce(() async {
    final products = await SearchApi.getProducts(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.products = products;
    });
  });

  Widget buildProduct(Product product) => ListTile(
    leading: Image.network(
      product.productImageLink,
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    ),
    title: Text(product.productName),
    subtitle: Text(product.productDescription),
  );
}
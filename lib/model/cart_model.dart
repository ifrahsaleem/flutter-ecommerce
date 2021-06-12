import 'package:flutter/material.dart';

class Cart {
  final String productId, productSize, productName, productCategory, productFlutterLink;
  final dynamic productPrice, productRating, productDiscount, quantity, productDCPrice;
  final int numOfItem;
  Cart({this.productId, this.numOfItem, this.productSize, this.productName, this.productCategory, this.productFlutterLink,
  this.productPrice, this.productRating, this.productDiscount, this.quantity, this.productDCPrice
  });

factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
    productId: json['_id'],
    productSize: json['produceSize'],
    productName: json['productName'],
    productCategory: json['productCategory'],
    productDiscount: json['productDiscount'],
    productPrice: json['productPrice'],
    productRating: json['productRating'],
    productFlutterLink: json['onlineImageLink'], 
        quantity: json['quantity'],
      productDCPrice: json['productDCPrice']

    );
  }
}

// List<Cart> demoCarts = [
//   Cart(productSize: 'Standard',
//       productName: 'Zen Brush',
//       productCategory: 'Brush',
//       productFlutterLink: 'assets/images/peachp.png',
//       productPrice: 450,
//       productRating: 3,
//       productDiscount: 10,
//       numOfItem: 2),
//   Cart(productSize: 'Standard',
//       productName: 'Zen Brush',
//       productCategory: 'Brush',
//       productFlutterLink: 'assets/images/peachp.png',
//       productPrice: 450,
//       productRating: '3',
//       productDiscount: '10%',
//       numOfItem: 2),
//   Cart(productSize: 'Standard',
//       productName: 'Zen Brush',
//       productCategory: 'Brush',
//       productFlutterLink: 'assets/images/peachp.png',
//       productPrice: 450,
//       productRating: 3,
//       productDiscount: 10,
//       numOfItem: 2),
// ];

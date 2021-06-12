import 'package:flutter/material.dart';
import 'package:team17_mobile/utils/color.dart';

class Product {
  final String productSize,
      productDescription,
      productDistributor,
      productId,
      productBGcolor,
      productName,
      productCategory,
      productImageLink,
      productFlutterLink,
      onlineImageLink;
  final dynamic productPrice,
      productRating,
      productDiscount,
      productComments,
      productStock,
      productNumofRatings,
      quantity,
      productDCPrice,
      PriceatPurchase;
  final bool productBestseller;

  Product({
    this.productId,
    this.productSize,
    this.productDescription,
    this.productDistributor,
    this.productBGcolor,
    this.productName,
    this.productCategory,
    this.productStock,
    this.productDiscount,
    this.productNumofRatings,
    this.productBestseller,
    this.productPrice,
    this.productRating,
    this.productImageLink,
    this.productFlutterLink,
    this.productComments,
    this.onlineImageLink,
    this.productDCPrice,
    this.quantity,
    this.PriceatPurchase,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['_id'],
        productSize: json['productSize'],
        productDescription: json['productDescription'],
        productDistributor: json['productDistributor'],
        productBGcolor: json['productBGcolor'],
        productName: json['productName'],
        productCategory: json['productCategory'],
        productStock: json['productStock'],
        productDiscount: json['productDiscount'],
        productNumofRatings: json['productNumofRatings'],
        productBestseller: json['productBestseller'],
        productPrice: json['productPrice'],
        productRating: json['productRating'],
        productImageLink: json['productImageLink'],
        productFlutterLink: json['productFlutterLink'],
        productComments: json['productComments'],
        onlineImageLink: json['onlineImageLink'],
        productDCPrice: json['productDCPrice'],
        quantity: json['quantity'],
        PriceatPurchase: json['PriceatPurchase']
    );

  }
}
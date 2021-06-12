import 'package:team17_mobile/model/products.dart';

class Refund {
  final String
      refundId,
      email,
      invoiceID;
  final Product product;
  final bool approved;
  final dynamic quantity, priceAtPurchase;

  Refund({
    this.approved,
    this.refundId,
    this.email,
    this.invoiceID,
    this.product,
    this.quantity,
    this.priceAtPurchase
  });

  factory Refund.fromJson(Map<String, dynamic> json) {
    Product pr = Product.fromJson(json['productID']);
    return Refund(
      refundId: json['_id'],
      approved: json['approved'],
      email: json['email'],
      invoiceID: json['invoiceID'],
      quantity: json['quantity'],
      priceAtPurchase: json['PriceatPurchase'],
      product: pr,
    );
  }
}
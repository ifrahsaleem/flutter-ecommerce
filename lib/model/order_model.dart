import 'package:team17_mobile/model/products.dart';

class Order {
  final String status,
      orderID,
      name,
      address,
      city,
      country,
      userEmail;
  final List<Product> products;
  final dynamic date,total, items;

  Order({
    this.status,
    this.orderID,
    this.name,
    this.address,
    this.city,
    this.country,
    this.userEmail,
    this.date,
    this.total,
    this.products,
    this.items
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    print(list.runtimeType);
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return Order(
      orderID: json['_id'],
      status: json['status'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      userEmail: json['userEmail'],
      date: json['date'],
      total: json['total'],
      products: productList,
      items: json['items'],
    );
  }
}
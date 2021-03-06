import 'package:meta/meta.dart';

class Product {
  final int id;
  final String name;
  final String url;
  final int year;
  final double price;
  final quantity;

  Product({
    @required this.id,
    @required this.name,
    this.url,
    @required this.year,
    @required this.price,
    @required this.quantity}):
        assert(name != null),
        assert(year != null),
        assert(quantity >= 0)
  ;
  factory Product.fromJSON({Map<String, dynamic> data}) {
    return Product(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      url: data['url'] ?? '',
      year: data['year'] ?? 200,
      quantity: data['role'] ?? 1,
    );
  }

}
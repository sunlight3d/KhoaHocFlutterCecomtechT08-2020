import 'package:meta/meta.dart';

class Product {
  final int id;
  final String name;
  final int year;
  final amount;

  Product({
    @required this.id,
    @required this.name,
    @required this.year,
    @required this.amount}):
        assert(name != null),
        assert(year != null),
        assert(amount >= 0)
  ;
  get fullName => '$name - $year';
}
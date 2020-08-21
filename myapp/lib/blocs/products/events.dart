import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable{
  const ProductsEvent();
}
class ProductsEventFetch extends ProductsEvent {
  final int limit;
  ProductsEventFetch({this.limit});
  @override
  List<Object> get props => [limit];
}
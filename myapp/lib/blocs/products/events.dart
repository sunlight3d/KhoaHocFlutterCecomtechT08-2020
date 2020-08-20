import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable{
  const ProductsEvent();
}
class ProductsEventFetch extends ProductsEvent {
  final int page;
  final int limit;
  ProductsEventFetch({this.page, this.limit});
  @override
  List<Object> get props => [page, limit];
}
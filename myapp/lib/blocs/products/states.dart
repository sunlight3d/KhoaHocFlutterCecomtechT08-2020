import 'package:equatable/equatable.dart';
import 'package:myapp/models/models.dart';
import 'package:meta/meta.dart';
abstract class ProductsState extends Equatable {
  final List<Product> products;//total products
  ProductsState({this.products});
}
class ProductsStateInitial extends ProductsState {
  ProductsStateInitial({products}): super(products: products);
  @override
  List<Object> get props => [];
}
class ProductsStateFetching extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsStateSuccess extends ProductsState {
  final bool hasReachEnd;
  ProductsStateSuccess({products, this.hasReachEnd}): super(products: products);

  ProductsStateSuccess copyWith({
    List<Product> products,
    int currentPage,
    bool hasReachEnd,
  }) {
    return ProductsStateSuccess(
        products: products ?? this.products,
        hasReachEnd: hasReachEnd ?? this.hasReachEnd
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [products, hasReachEnd];
}


class ProductsStateFailed extends ProductsState {
  final String message;

  ProductsStateFailed({products, this.message}): super(products: products);

  ProductsStateFailed copyWith({
    String message,
    List<Product> products,
    int currentPage
  }) {
    return ProductsStateFailed(
    message: message ?? this.message,
        products: products ?? this.products
    );
  }
  @override
  List<Object> get props => [message, products];
}


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
  List<Object> get props => [products,products.length];
}
class ProductsStateFetching extends ProductsState {
  ProductsStateFetching({products}): super(products: products);
  @override
  List<Object> get props => [products.length, products];
}
class ProductsStateSuccess extends ProductsState {
  final bool hasReachEnd;
  ProductsStateSuccess({products, this.hasReachEnd}): super(products: products);

  ProductsStateSuccess copyWith({
    List<Product> products,
    int currentPage,
    bool hasReachEnd,
  }) {
    final newObject = ProductsStateSuccess(
        products: products ?? this.products,
        hasReachEnd: hasReachEnd ?? this.hasReachEnd
    );
    return newObject;
  }
  @override
  // TODO: implement props
  List<Object> get props => [products, hasReachEnd, products.length];
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
  List<Object> get props => [message, products, products.length];
}


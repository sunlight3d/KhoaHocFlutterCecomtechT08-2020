import 'package:equatable/equatable.dart';
import 'package:myapp/models/models.dart';
import 'package:meta/meta.dart';
abstract class ProductsState extends Equatable {
  const ProductsState();
}
class ProductsStateInitial extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsStateFetching extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsStateSuccess extends ProductsState {
  final List<Product> products; //total products
  final int currentPage;
  final bool hasReachEnd;
  ProductsStateSuccess({
    this.hasReachEnd = false,
    @required this.products,
    @required this.currentPage})
      :assert(products != null),
      assert(currentPage >= 0);

  ProductsStateSuccess copyWith({
    List<Product> products,
    int currentPage,
    bool hasReachEnd,
  }) {
    return ProductsStateSuccess(
        currentPage: currentPage ?? this.currentPage,
        products: products ?? this.products,
        hasReachEnd: hasReachEnd ?? this.hasReachEnd
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [products, currentPage];
}
class ProductsStateReachEnd extends ProductsState {
  final List<Product> products; //total products
  final int currentPage;
  ProductsStateReachEnd({
    @required this.products,
    @required this.currentPage})
      :assert(products != null),
        assert(currentPage >= 0);
  @override
  // TODO: implement props
  List<Object> get props => [products, currentPage];
}

class ProductsStateFailed extends ProductsState {
  final int currentPage;
  final List<Product> products;//total products
  final String message;
  ProductsStateFailed({
    @required this.message,
    @required this.currentPage,
    @required this.products}):
        assert(products != null),
        assert(message != null),
        assert(currentPage >= 0);

  ProductsStateFailed copyWith({
    String message,
    List<Product> products,
    int currentPage
  }) {
    return ProductsStateFailed(
    message: message ?? this.message,
        currentPage: currentPage ?? this.currentPage,
        products: products ?? this.products
    );
  }
  @override
  List<Object> get props => [message, currentPage, products];
}


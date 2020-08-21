import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/products/events.dart';
import 'package:myapp/blocs/products/states.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/repositories/products_repository.dart';
import 'package:myapp/repositories/response.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;
  ProductsBloc({this.productsRepository}): super(ProductsStateInitial());
  @override
  Stream<ProductsState> mapEventToState(ProductsEvent productsEvent) async* {
    try {
      if(productsEvent is ProductsEventFetch && !(state is ProductsStateFetching)) {
        yield ProductsStateFetching();
        if(state is ProductsStateInitial) {
          Response response = await this.productsRepository
              .fetchProducts(offset: state.products.length, limit: productsEvent.limit);
          if(response.error != null) {
            yield ProductsStateFailed(
               message: response.error,
               products: []
            );
          } else {
            List<Product> products = response.result as List<Product>;
            yield ProductsStateSuccess(
                products: products,
                hasReachEnd: products.isEmpty
            );
          }
        } else {
          Response response = await this.productsRepository
              .fetchProducts(offset: state.products.length, limit: productsEvent.limit);
          if(response.error != null) {
            if(state is ProductsStateFailed) {
              yield (state as ProductsStateFailed).copyWith(
                message: response.error,
              );
            } else if(state is ProductsStateSuccess) {
              yield ProductsStateFailed(
                  message: response.error,
                  products: (state as ProductsStateSuccess).products);
            }
          } else {
            List<Product> products = response.result as List<Product>;
            if(state is ProductsStateFailed) {
              yield (state as ProductsStateFailed).copyWith(
                  products: (state as ProductsStateFailed).products
                      + ((products.isEmpty == true) ? [] : products),
              );
            } else if(state is ProductsStateSuccess) {
              yield (state as ProductsStateSuccess).copyWith(
                  products: (state as ProductsStateSuccess).products
                      + ((products.isEmpty == true) ? [] : products),
                  hasReachEnd: products.isEmpty
              );
            }
          }
        }
      }
    }catch(exception) {
      yield ProductsStateFailed(message: 'Cannot load products: ${exception.toString()}');
    }
  }
}
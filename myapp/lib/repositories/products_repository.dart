import 'dart:convert';

import 'package:myapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/repositories/constants.dart';
import 'package:myapp/repositories/response.dart';

final URL_FETCH_PRODUCTS = ({int page, int limit}) =>
    BASE_URL + '/products/fetch_products?page=$page&limit=$limit';

class ProductsRepository {
  final http.Client httpClient;
  ProductsRepository({this.httpClient});
  Future<Response> fetchProducts({int page, int limit}) async {
    List<Product> products = new List<Product>();
    final response = await this.httpClient.get(
        URL_FETCH_PRODUCTS(page: page, limit: limit)
    );
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
//        _user = User.fromJSON(
//            data: json.decode(response.body)['data']
//        );
        return Response(result: {}, error: null);
      } else {
        return Response(
            result: null, error: json.decode(response.body)['message']);
      }
    }
    return Response(
        result: null,
        error: 'Internal server error');
  }
}


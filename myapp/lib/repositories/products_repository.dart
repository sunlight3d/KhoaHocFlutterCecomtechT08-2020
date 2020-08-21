import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/repositories/constants.dart';
import 'package:myapp/repositories/response.dart';
import 'package:myapp/models/models.dart';

final URL_FETCH_PRODUCTS = ({int offset, int limit}) =>
    BASE_URL + '/products/fetch_products?offset=$offset&limit=$limit';

class ProductsRepository {
  final http.Client httpClient;
  ProductsRepository({this.httpClient});
  Future<Response> fetchProducts({int offset, int limit}) async {
    List<Product> products = new List<Product>();
    final response = await this.httpClient.get(
        URL_FETCH_PRODUCTS(offset: offset, limit: limit)
    );
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
       final responseData = json.decode(response.body)['data'] as List;

       final List<Product> products = responseData.map((item) {
         print('haha');
         final product =  Product(
           id: item['id'] ?? 0,
           name: item['name'] ?? '',
           url: item['url'] ?? '',
           year: item['year'] ?? 200,
           price: item['price'].toDouble(),
           quantity: item['quantity'] ?? 1,
         );
         return product;
       }).toList();
        return Response(result: products, error: null);
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


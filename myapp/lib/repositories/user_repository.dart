import 'dart:convert';

import 'package:myapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/repositories/constants.dart';

const URL_LOGIN = BASE_URL + '/users/login';
const URL_REGISTER = BASE_URL + '/users/register';
//final URL_GET_PRODUCTS = (limit, offset) => BASE_URL + '/products?limit=$limit&offset=$offset';

class UserRepository {
  final http.Client httpClient;
  UserRepository({this.httpClient});
  Future<User> login({String email, String password}) async {
    User _user = null;
    final response = await this.httpClient.post(
      URL_LOGIN,
      headers: headers,
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      })
    );
    if(response.statusCode == 200) {
      if(json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
        _user = User.fromJSON(
            data: json.decode(response.body)['data']
        );
      }
    }
    return _user;
  }
  Future<User> register({String email, String password}) async {
    User _user = null;
    final response = await this.httpClient.post(
        URL_REGISTER,
        headers: headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        })
    );
    if(response.statusCode == 200) {
      if(json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
        _user = User.fromJSON(
            data: json.decode(response.body)['data']
        );
      }
    }
    return _user;
  }
}
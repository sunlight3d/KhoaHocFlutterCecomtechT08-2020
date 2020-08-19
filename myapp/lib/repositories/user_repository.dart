import 'dart:convert';

import 'package:myapp/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/repositories/constants.dart';
import 'package:myapp/repositories/response.dart';

const URL_LOGIN = BASE_URL + '/users/login';
const URL_REGISTER = BASE_URL + '/users/register';
const URL_LOGOUT = BASE_URL + '/users/logout';
const URL_CHECK_TOKEN  = BASE_URL + '/users/check_token';
//final URL_GET_PRODUCTS = (limit, offset) => BASE_URL + '/products?limit=$limit&offset=$offset';

class UserRepository {
  final http.Client httpClient;
  UserRepository({this.httpClient});
  Future<Response> login({String email, String password}) async {
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
        return Response(result: _user, error: null);

      } else {
        return Response(result: null, error: json.decode(response.body)['message']);
      }
    }
    return Response(
        result: null,
        error: 'Internal server error');
  }
  Future<Response> register({String email, String password}) async {
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
        return Response(result: _user, error: null);

      } else {
        return Response(result: null, error: json.decode(response.body)['message']);
      }
    }
    return Response(
        result: null,
        error: 'Internal server error');
  }
  Future<Response> logout({String tokenKey}) async {
    User _user = null;
    final response = await this.httpClient.post(
        URL_LOGOUT,
        headers: headers,
        body: jsonEncode(<String, String>{
          'tokenKey': tokenKey,
        })
    );
    if(response.statusCode == 200) {
      if(json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
        return Response(result: {}, error: null);
      } else {
        return Response(result: null, error: json.decode(response.body)['message']);
      }
    }
    return Response(
        result: null,
        error: 'Internal server error');
  }
  Future<Response> checkToken({String tokenKey, String email}) async {
    final response = await this.httpClient.post(
        URL_CHECK_TOKEN,
        headers: headers,
        body: jsonEncode(<String, String>{
          'tokenKey': tokenKey,
          'email': email
        })
    );
    if(response.statusCode == 200) {
      if(json.decode(response.body)['status'] == 'STATUS_SUCCESS') {
        return Response(result: {}, error: null);
      } else {
        return Response(result: null, error: json.decode(response.body)['message']);
      }
    }
    return Response(
        result: null,
        error: 'Internal server error');
  }
}


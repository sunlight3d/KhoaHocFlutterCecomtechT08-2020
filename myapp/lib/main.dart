import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/blocs.dart';
import 'package:myapp/blocs/products/bloc.dart';
import 'package:myapp/repositories/products_repository.dart';
import 'package:myapp/repositories/repositories.dart';
import 'package:myapp/screens/screens.dart';
import 'package:myapp/screens/tab_screen.dart';
import 'package:http/http.dart' as http;

void main()  => runApp(MyApp());
class MyApp extends StatelessWidget {
  get httpClient => http.Client();

  @override
  Widget build(BuildContext context) {
    final UserRepository _userRepository = UserRepository(httpClient: httpClient);
    final ProductsRepository _productsRepository = ProductsRepository(httpClient: httpClient);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(userRepository: _userRepository),
        ),
        BlocProvider<ProductsBloc>(
          create: (BuildContext context) => ProductsBloc(productsRepository: _productsRepository),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(userRepository: _userRepository),
        },
      ),
    );
  }
}




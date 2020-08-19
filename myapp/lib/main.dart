import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/authentication.dart';
import 'package:myapp/repositories/repositories.dart';
import 'package:myapp/screens/screens.dart';
import 'package:myapp/screens/tab_screen.dart';
import 'package:http/http.dart' as http;

void main()  => runApp(MyApp());
class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository(httpClient: http.Client());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final x = AuthenticationBloc(userRepository: userRepository);
        return x;
      }
      ,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(userRepository: userRepository),
        },
      ),
    );
  }
}




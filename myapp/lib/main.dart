import 'package:flutter/material.dart';
import 'package:myapp/screens/screens.dart';
import 'package:myapp/screens/tab_screen.dart';

void main()  => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
      },
//      home: MainScreen()
    );
  }
}




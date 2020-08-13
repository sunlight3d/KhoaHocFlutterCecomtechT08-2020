import 'package:flutter/material.dart';
import 'package:myapp/screens/splash_screen.dart';

void main()  => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Cmd + Shift + \
    return MaterialApp(
      home: SplashScreen()
    );
  }
}




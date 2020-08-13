import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Image(
                  image: AssetImage('images/logo.jpeg'),
                  width: 200,
                  height: 200,
                ),
              ),
              Text('Welcome to my App', style: TextStyle(fontSize: 30),)
            ],
          ),
        )
      )
    );
  }
}
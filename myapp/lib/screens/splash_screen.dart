import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => MainScreen()
          )
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.greenAccent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: CircleAvatar(
                  radius: 110,
                  backgroundColor: Color(0xffFF00FF),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(
                      'images/logo.jpeg',

                    ),
                  ),
                )
              ),
              Text('ECommerce App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Text('Welcome to my App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),)
            ],
          ),
        )
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/types/screen_type.dart';
import 'package:myapp/widgets/header_button.dart';
import 'package:myapp/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreen();
}
//Thang nay moi la lam nhieu
class _MainScreen extends State<MainScreen> {
  //states
  ScreenType _screenType = ScreenType.login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderButton(
                  title: 'Login',
                  onPressed: () {
                    setState((){
                      _screenType = ScreenType.login;
                    });
                  },
                  isShowBottomLine: _screenType == ScreenType.login,
                ),
                HeaderButton(
                  title: 'Register',
                  onPressed: () {
                    setState((){
                      _screenType = ScreenType.register;
                    });
                  },
                  isShowBottomLine: _screenType == ScreenType.register,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _screenType == ScreenType.login ? LoginWidget() : RegisterWidget(),
            )
          ],
        ),
      )
    );
  }
}
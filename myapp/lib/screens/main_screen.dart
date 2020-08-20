import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/blocs.dart';
import 'package:myapp/repositories/repositories.dart';
import 'package:myapp/types/screen_type.dart';
import 'package:myapp/widgets/header_button.dart';
import 'package:myapp/widgets/widgets.dart';

import 'tab_screen.dart';

class MainScreen extends StatefulWidget {
  final UserRepository userRepository;
  MainScreen({this.userRepository});
  @override
  State<StatefulWidget> createState() => _MainScreen();
}
//Thang nay moi la lam nhieu
class _MainScreen extends State<MainScreen> {
  //states
  ScreenType _screenType = ScreenType.login;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder:  (context, authenticationState) {
          if(authenticationState is AuthenticationStateFailed) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertWidget(
                    title: 'Error',
                    message: 'Login failed: ${authenticationState.message}',
                    onPressedOK: () {

                    },
                    onPressedCancel: null,
                  );
                }
            );
          } else if(authenticationState is AuthenticationStateLoggingIn) {
            return
              Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new CircularProgressIndicator(),
                        new Text("Loading"),
                      ],
                    ),
                  ),
              );
          }
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
                      child: _screenType == ScreenType.login ?
                      LoginWidget(userRepository: this.widget.userRepository) :
                      RegisterWidget(userRepository: this.widget.userRepository),
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}
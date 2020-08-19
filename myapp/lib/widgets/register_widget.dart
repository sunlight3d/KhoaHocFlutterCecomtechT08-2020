import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Validators/validators.dart';
import 'package:myapp/blocs/authentication.dart';
import 'package:myapp/local_databases/sqlite_db.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/repositories/repositories.dart';
import 'package:myapp/screens/tab_screen.dart';
import 'package:myapp/types/role_type.dart';

import 'alert_widget.dart';

class RegisterWidget extends StatefulWidget {
  final UserRepository userRepository;
  RegisterWidget({this.userRepository});
  @override
  State<StatefulWidget> createState() => _RegisterWidget();
}
class _RegisterWidget extends State<RegisterWidget> {
  //states
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();
  //populated
  bool get isPopulatedEmail => isValidEmail
      || _emailController.text.isEmpty;

  bool get isPopulatedPassword => isValidPassword
      || _passwordController.text.isEmpty;

  bool get isPopulatedRetypePassword => (isValidRetypePassword && isPasswordMatch)
      || _retypePasswordController.text.isEmpty;

  //valid
  bool get isValidEmail => Validators.isValidEmail(_emailController.text);
  bool get isValidPassword => Validators.isValidPassword(_passwordController.text);
  bool get isPasswordMatch => _passwordController.text == _retypePasswordController.text;
  bool get isValidRetypePassword =>
      Validators.isValidPassword(_retypePasswordController.text);

  bool get isValidEmailAndPasword => isValidEmail && isValidPassword
                                      && isValidRetypePassword;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, authenticationState){
      if(authenticationState is AuthenticationStateSuccess) {
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => TabScreen(
                    roleType: authenticationState.user.role
                )
            )
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(padding: EdgeInsets.only(top: 10),
            child: Text(
              'Register to your Account',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText:  'Enter your email'
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidate: true,
              autocorrect: false,
              validator: (value) => this.isPopulatedEmail ? null : 'Invalid email format',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText:  'Enter your password'
              ),
              obscureText: true,
              autovalidate: true,
              autocorrect: false,
              validator: (value) => this.isPopulatedPassword ? null : 'Invalid password format',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
                controller: _retypePasswordController,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText:  'Retype your password'
                ),
                obscureText: true,
                autovalidate: true,
                autocorrect: false,
                validator: (value) {
                  if (isPopulatedRetypePassword == true) {
                    return null;
                  } else {
                    if (isPasswordMatch == false) {
                      return 'Pass does not match';
                    } else if (isValidRetypePassword == false) {
                      return 'Password is invalid';
                    } else {
                      return null;
                    }
                  }
                }),
          ),
          SizedBox(
            child: RaisedButton(
              color: Colors.green,
              onPressed:() async {
                if(isValidEmailAndPasword == false){
                  //Show snackbar
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertWidget(
                          title: 'Error',
                          message: 'Invalid email and password',
                          onPressedOK: () {
                            Navigator.of(context).pop();
                          },
                          onPressedCancel: null,
                        );
                      }
                  );
                  return;
                }
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationEventRegister(
                    email: _emailController.text,
                    isRemember: true,
                    password: _passwordController.text));
              },
              child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            height: 40,
            width: double.infinity,
          )
        ],
      );
    });

  }
}
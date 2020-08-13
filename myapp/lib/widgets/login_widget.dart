import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginWidget();
}
class _LoginWidget extends State<LoginWidget> {
  //states
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Login to your Account',
            style: TextStyle(fontSize: 22),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText:  'Enter your email'
            ),
            keyboardType: TextInputType.emailAddress,
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              //return loginState.isValidEmail ? null : 'Invalid email format';
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText:  'Enter your password'
            ),
            obscureText: true,
            autovalidate: true,
            autocorrect: false,
            validator: (_) {
              //return loginState.isValidEmail ? null : 'Invalid email format';
            },
          ),
        ),
        CheckboxListTile(
          title: Text("Remember me"),
          value: this._rememberMe,
          onChanged: (newValue) {
            setState(() {
              _rememberMe = newValue;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
        SizedBox(
          child: RaisedButton(
            color: Colors.green,
            onPressed:(){

            },
            child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          height: 40,
          width: double.infinity,
        )
      ],
    );
  }
}
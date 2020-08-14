import 'package:flutter/material.dart';
import 'package:myapp/Validators/validators.dart';

class RegisterWidget extends StatefulWidget {
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

  bool get isPopulatedRetypePassword => isValidRetypePassword
      || _retypePasswordController.text.isEmpty;

  //valid
  bool get isValidEmail => Validators.isValidEmail(_emailController.text);
  bool get isValidPassword => Validators.isValidPassword(_passwordController.text);
  bool get isPasswordMatch() {
    
    return _passwordController.text == _retypePasswordController.text;
  };
  bool get isValidRetypePassword =>
      Validators.isValidPassword(_retypePasswordController.text);

  bool get isValidEmailAndPasword => isValidEmail && isValidPassword
                                      && isValidRetypePassword;

  @override
  Widget build(BuildContext context) {
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
            validator: (value) =>
              this.isPopulatedRetypePassword ? null
                  : (isPasswordMatch == false ? 'Pass does not match' : 'Password is invalid'),
          ),
        ),
        SizedBox(
          child: RaisedButton(
            color: Colors.green,
            onPressed:(){

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
  }
}
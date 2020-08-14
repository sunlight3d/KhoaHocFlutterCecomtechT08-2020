import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Validators/validators.dart';
import 'package:myapp/screens/tab_screen.dart';
import 'package:myapp/types/role_type.dart';
import 'package:myapp/widgets/alert_widget.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginWidget();
}
class _LoginWidget extends State<LoginWidget> {
  static const methodChannel = const MethodChannel('cecomtech.training/printf');
  //states
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool get isValidEmail => Validators.isValidEmail(_emailController.text);
  bool get isValidPassword => Validators.isValidPassword(_passwordController.text);

  bool get isPopulatedEmail => isValidEmail
                                || _emailController.text.isEmpty;
  bool get isPopulatedPassword => isValidPassword
                                  || _passwordController.text.isEmpty;
  bool get isValidEmailAndPasword => isValidEmail && isValidPassword;

  bool _rememberMe = false;

  Future<void> _testCallNativePrint() async {
    try {
      await methodChannel.invokeMethod('printf',<String, dynamic>{
        'name': 'Hoang',
        'age': 18,
      });
      print('hahah ');
    } on PlatformException catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: EdgeInsets.only(top: 10),
            child: Text(
              'Login to your Account',
              style: TextStyle(fontSize: 22),
            ),),
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
                  _testCallNativePrint();
                  return;
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
                  //Gui Api
                  Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => TabScreen(roleType: RoleType.admin)
                    )
                  );
                },
                child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              height: 40,
              width: double.infinity,
            ),
          ],
        )
    );
  }
}
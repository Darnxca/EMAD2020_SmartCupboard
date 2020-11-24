
import 'package:flutter/material.dart';

import 'package:smart_cupboard/Screens/Login/components/background.dart';
import 'package:smart_cupboard/Screens/Preferenze/preferenze_screen.dart';
import 'package:smart_cupboard/Screens/Signup/signup_screen.dart';
import 'package:smart_cupboard/components/already_have_an_account_acheck.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/components/rounded_password_field.dart';
import 'package:provider/provider.dart';
import '../../../AuthenticationService.dart';


class Login extends StatefulWidget {

  State createState() => new LoginState();
}

class LoginState  extends State<Login> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.02),
              Image(image: AssetImage('assets/images/logo.png'),
                height: size.height * 0.35,),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                controller: emailController,
                validator: (input){
                  if(input.isEmpty()){
                      return 'Inserisci username';
                  }else{
                    return input;
                  }
                },
                hintText: "Your Email",
                onChanged: (input) {email = input;},
              ),
              RoundedPasswordField(
                controller: passwordController,
                validator: (input){
                  if(input.length < 6 ){
                    return 'Inserisci password con più di 6 caratteri';
                  }else{
                    return input;
                  }
                },
                onChanged: (input) {password = input;},
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
    ),
      );
  }

}
 /* const Body({
    Key key,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}*/

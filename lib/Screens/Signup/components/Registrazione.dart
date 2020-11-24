
import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/Login/login_screen.dart';
import 'package:smart_cupboard/Screens/Signup/components/background.dart';
import 'package:smart_cupboard/components/already_have_an_account_acheck.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/components/rounded_password_field.dart';
import 'package:provider/provider.dart';
import '../../../AuthenticationService.dart';
class Registrazione extends StatefulWidget {

  State createState() => new RegistrazioneState();
}

class RegistrazioneState extends State<Registrazione> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cognomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "REGISTRATI",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05), //tipo padding
              Image(image: AssetImage('assets/images/logo.png'),
                height: size.height * 0.3,),
              RoundedInputField(
                hintText: "Nome",
                controller: nomeController,
                onChanged: (input) {},
              ),
              RoundedInputField(
                hintText: "Cognome",
                controller: cognomeController,
                onChanged: (input) {},
              ),
              RoundedInputField(
                controller: emailController,
                validator: (input){
                  if(input.isEmpty()){
                    return 'Inserisci email valida';
                  }else{
                    return input;
                  }
                },
                hintText: "Your username",
                onChanged: (input) {},
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
                onChanged: (input) {},
              ),
              RoundedButton(
                text: "Registrati",
                press: () {
                context.read<AuthenticationService>().signUp(
                    nome: nomeController.text.trim(),
                    cognome: cognomeController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    context: context,
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
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

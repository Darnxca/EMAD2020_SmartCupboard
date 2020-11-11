import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_cupboard/Screens/Login/login_screen.dart';
import 'package:smart_cupboard/Screens/Signup/components/background.dart';
import 'package:smart_cupboard/Screens/Signup/components/or_divider.dart';
import 'package:smart_cupboard/Screens/Signup/components/social_icon.dart';
import 'package:smart_cupboard/components/already_have_an_account_acheck.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/components/rounded_password_field.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Cognome",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Registrati",
              press: () {},
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
    );
  }
}

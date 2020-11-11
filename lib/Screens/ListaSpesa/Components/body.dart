import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';

import 'package:smart_cupboard/Screens/Login/components/background.dart';
import 'package:smart_cupboard/Screens/Signup/signup_screen.dart';
import 'package:smart_cupboard/Screens/Welcome/welcome_screen.dart';
import 'package:smart_cupboard/components/already_have_an_account_acheck.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/components/rounded_password_field.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Lista della spesa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),


          ],
        ),
      ),
    );
  }
}

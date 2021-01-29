import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';

import 'package:smart_cupboard/Screens/Login/components/background.dart';
import 'package:smart_cupboard/Screens/Signup/signup_screen.dart';
import 'package:smart_cupboard/Screens/Welcome/welcome_screen.dart';
import 'package:smart_cupboard/components/already_have_an_account_acheck.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/components/rounded_password_field.dart';
import 'package:smart_cupboard/constants.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
            Icon(Icons.person_outline_rounded, size: 150),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 30, right: 0, bottom: 0),
                child: Container(

                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 0),
                        child: Text(
                          "Nome",

                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        width: 275.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 5, right: 0, bottom: 0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[800]),
                                hintText: "Antonio",
                                fillColor: Colors.white70),
                          ),
                        ),
                      ),

                    ],

                  )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 30, right: 0, bottom: 0),
                child: Container(

                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: Text(
                            "Cognome",

                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          width: 240.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800]),
                                  hintText: "Rossi",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),

                      ],

                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 30, right: 0, bottom: 0),
                child: Container(

                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: Text(
                            "Email",

                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          width: 280.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 40, top: 5, right: 0, bottom: 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800]),
                                  hintText: "a.rossi@gmail.com",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),

                      ],

                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 30, right: 0, bottom: 0),
                child: Container(

                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: Text(
                            "Password",

                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          width: 238.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 5, right: 0, bottom: 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800]),
                                  hintText: "1234",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),

                      ],

                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 30, right: 0, bottom: 0),
                child: Container(

                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          child: Text(
                            "Cambia",

                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          width: 260.0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 21, top: 5, right: 0, bottom: 0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800]),
                                  hintText: "Inserisci Password",
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),

                      ],

                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, top: 30, right: 0, bottom: 0),
                child: ButtonTheme(
                  minWidth: 250.0,
                  height: 60.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29.0),
                        side: BorderSide(color: kPrimaryColor)),
                    onPressed: () {},
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    child: Text("Salva Modifiche".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                ),
                ),
            ],
          )

        ),
      ),
    );
  }
}

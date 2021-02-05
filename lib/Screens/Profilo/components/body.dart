import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/modal/Utente.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  GetDataService getDataService = GetDataService();
  String pass,oldPass;
  Future<Utente> getData;

  @override
  void initState() {
     getData = getDataService.getUtente();

        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return SafeArea(
        child: FutureBuilder(
        future: getData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {
        print("Errore" + snapshot.error.toString());
        return Text(snapshot.error.toString());
      } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        print(snapshot.data);
        return Scaffold(
          body: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Icon(Icons.person_outline_rounded, size: 150),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 30, right: 0, bottom: 0),
                    child: Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 0, right: 0, bottom: 0),
                              child: Text(
                                "Nome",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 0),
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, right: 0, bottom: 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                      hintText: snapshot.data.nome,
                                      fillColor: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 30, right: 0, bottom: 0),
                    child: Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 0, right: 10, bottom: 0),
                              child: Text(
                                "Cognome",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 0),
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 0, bottom: 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                      hintText: snapshot.data.cognome,
                                      fillColor: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 30, right: 0, bottom: 0),
                    child: Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 0, right: 0, bottom: 0),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              width: 270.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 5, right: 0, bottom: 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                      hintText: snapshot.data.email,
                                      fillColor: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text("Cambia password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 65, top: 20, right: 0, bottom: 0),
                    child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 21, vertical: 0),
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 0, bottom: 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                      hintText: "Vecchia password",
                                      fillColor: Colors.white70),
                                  onChanged: (input) {oldPass = input;},

                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 65, top: 20, right: 0, bottom: 0),
                    child: Container(
                        child: Row(
                          children: <Widget>[

                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 21, vertical: 0),
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 0, bottom: 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(
                                      contentPadding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                      hintText: "Nuova password",
                                      fillColor: Colors.white70),
                                  onChanged: (input) {pass = input;},

                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0, top: 30, right: 0, bottom: 0),
                    child: RoundedButton(
                      text: "Salva modifiche",
                      press: () {
                        if(!(pass == "")) {
                          getDataService.changePassword(oldPass,pass,context);
                        }
                      },
                    ),
                  ),
                ],
              )),
        );
      }
      return Text("Loading...");
    }));
    }
  }

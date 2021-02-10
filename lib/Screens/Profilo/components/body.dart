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
            
          body: SingleChildScrollView(
            child: Container(
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
                                    left: 0, top: 10, right: 0, bottom: 0),
                                child: Text(
                                  "Nome",
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 0),
                                width: 225.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 0, right: 0, bottom: 0),
                                  child: TextField(
                                    enabled: false,
                                    textAlign: TextAlign.center,
                                    decoration: new InputDecoration(
                                        hintText: snapshot.data.nome,

                                        labelStyle: new TextStyle(color: const Color(0xFF808080)),
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey
                                            )
                                        )
                                    ),
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
                                    left: 0, top: 10, right: 10, bottom: 0),
                                child: Text(
                                  "Cognome",
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 0),
                                width: 220.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 0, right: 0, bottom: 0),
                                  child: TextField(
                                    enabled: false,
                                    textAlign: TextAlign.center,
                                    decoration: new InputDecoration(
                                        hintText: snapshot.data.cognome,

                                        labelStyle: new TextStyle(color: const Color(0xFF808080)),
                                        border: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey
                                            )
                                        )
                                    ),
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
                                    left: 0, top: 10, right: 0, bottom: 0),
                                child: Text(
                                  "Email",
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                width: 240.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 0, right: 0, bottom: 0),

                                    child: TextField(
                                      enabled: false,
                                      textAlign: TextAlign.center,
                                      decoration: new InputDecoration(
                                          hintText: snapshot.data.email,

                                          labelStyle: new TextStyle(color: const Color(0xFF808080)),
                                          border: new UnderlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey
                                              )
                                          )
                                      ),
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
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 20, right: 0, bottom: 0),
                      child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 0),
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 5, right: 0, bottom: 0),
                                 child: TextFormField(
                                    initialValue: '',
                                   obscureText:true,
                                   enableSuggestions: false,
                                   autocorrect: false,
                                    decoration: InputDecoration(
                                      labelText: 'Vecchia password',
                                      border: OutlineInputBorder(),
                                    ),
                                   onChanged: (input) {oldPass = input;},
                                  ),

                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 20, right: 0, bottom: 0),
                      child: Container(
                          child: Row(
                            children: <Widget>[

                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 0),
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 5, right: 0, bottom: 0),
                                  child: TextFormField(
                                    initialValue: '',
                                    obscureText:true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nuova password',
                                      border: OutlineInputBorder(),
                                    ),
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
          ),
        );
      }
      return Text("Loading...");
    }));
    }
  }

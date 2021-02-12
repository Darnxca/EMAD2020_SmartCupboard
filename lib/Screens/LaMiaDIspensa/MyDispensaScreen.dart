import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/Screens/HomePage/Components/MainDrawer.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';
import 'package:smart_cupboard/Screens/LaMiaDIspensa/components/body.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/modal/DispensaEntity.dart';
import 'package:smart_cupboard/modal/Prodotto.dart';
import '../../constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyDispensaScreen extends StatefulWidget {
  State createState() => new MyDispensaScreenState();
}

class MyDispensaScreenState extends State<MyDispensaScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Prodotto p;
  GetDataService service = GetDataService();
  String dataSharedPreferences;
  SharedPreferences prefs;
  static const List<IconData> icons = const [Icons.qr_code, Icons.keyboard];
  String codice;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future getCodiceEan(BuildContext context) async {
    codice = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancella", true, ScanMode.BARCODE);

    return service.getProdottiFromFirebase(codice, context);
  }

  void _tornaindietro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    Color backgroundColor = kPrimaryColor;
    Color foregroundColor = White;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'La mia dispensa',
          style: TextStyle(fontSize: 25.0),
        ),
        leading: BackButton(
          onPressed: _tornaindietro,
        ),
      ),
      drawer: MainDrawer(),
      body: BodyExpansionPanel(),
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {
                  if (index == 1) {
                    _settingModalBottomSheet(context);
                  } else {
                    getCodiceEan(context);
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              heroTag: null,
              backgroundColor: kPrimaryColor,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform:
                        new Matrix4.rotationZ(_controller.value * 0.5 * 3.14),
                    alignment: FractionalOffset.center,
                    child: new Icon(_controller.isDismissed
                        ? Icons.add
                        : Icons.close_sharp),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    String dropdownValue = 'Farine e derivati';
    Size size = MediaQuery.of(context).size;

    String nomeProdotto;

    GetDataService service = GetDataService();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.maxFinite,
              height: size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                    child: RoundedInputField(
                      hintText: "Inserisci nome prodotto",
                      icon: null, //di default ha l'icona user
                      validator: (input) {
                        if (input.isEmpty()) {
                          return 'Inserisci nome prodotto';
                        } else {
                          return input;
                        }
                      },
                      onChanged: (input) {
                        nomeProdotto = input;
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 45.0),
                      child: Text(
                        "Seleziona categoria",
                        style: TextStyle(fontSize: 17, color: Black),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 45.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Black),
                        underline: Container(
                          height: 2,
                          color: kPrimaryColor,
                        ),
                        onChanged: (String newValue) {
                          dropdownValue = newValue;
                          //categoria = newValue;
                        },
                        items: <String>[
                          'Farine e derivati',
                          'Latte e derivati',
                          'Frutta',
                          'Verdura',
                          'Carne',
                          'Dolci',
                          'Spezie',
                          'Scatolati',
                          'Oli',
                          'Altro'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Center(
                    child: RoundedButton(
                      text: "Aggiungi alla lista",
                      press: () {
                        DispensaEntity d = DispensaEntity(
                            DateTime.now().millisecondsSinceEpoch.toString(),
                            nomeProdotto,
                            dropdownValue);
                        service.inserisciProdotto(d).then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyDispensaScreen();
                                //return tempScreen();
                              },
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

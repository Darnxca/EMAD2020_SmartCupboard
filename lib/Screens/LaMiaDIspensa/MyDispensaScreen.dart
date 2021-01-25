
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/Screens/HomePage/Components/MainDrawer.dart';
import 'package:smart_cupboard/Screens/LaMiaDIspensa/components/body.dart';
import 'package:smart_cupboard/Screens/temp/temp_screen.dart';
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

  Future getCodiceEan() async {
    return codice = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancella", true, ScanMode.BARCODE);

    /*setState(() {
      print(codice);
      service.getProdotti(codice);
    });*/
  }

  Widget build(BuildContext context) {
    Color backgroundColor = kPrimaryColor;
    Color foregroundColor = White;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('La mia dispensa'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          //return AggiuntaProdotto();
                          return tempScreen();
                        },
                      ),
                    );
                  } else {
                    getCodiceEan().then((value) {
                      service.getProdottiFromFirebase(value);
                    });
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
}

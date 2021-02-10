import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/modal/ListaSpesaEntity.dart';
import '../../../constants.dart';
import 'package:smart_cupboard/item.dart';

import '../MyDispensaScreen.dart';

class BodyExpansionPanel extends StatefulWidget {
  BodyExpansionPanel({Key key}) : super(key: key);

  @override
  _BodyExpansionPanelState createState() => _BodyExpansionPanelState();
}

class _BodyExpansionPanelState extends State<BodyExpansionPanel> {
  String data ;

  GetDataService getDataService = GetDataService();

  Future<List<Item>> _getData;

  @override
  void initState() {
    //prende i dati dal database e inseriti in _getData se non lo metto in
    //initState ogni volta che voglio espandere il pannello mi ricarica tutto
    _getData = getDataService.getDispensa2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
     return FutureBuilder(
      future: _getData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("Errore" + snapshot.error.toString());
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
                setState(() => snapshot.data[index].isExpanded = !isExpanded);
            },
            children: snapshot.data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/imgCategorie/" + item.urlImg),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.height,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.grey[350].withOpacity(0.85),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                                ),
                                child: Text(
                                  item.categoryName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),

                    ),
                  );
                },
                body: new ListView.builder(
                    itemCount: item.prodottiDipensa.length,
                    shrinkWrap: true,
                    // risolve l'errore pos 12: 'child.hasSize'
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0,
                            right: 18.0,
                            bottom: 5.0),
                        child: Table(

                          defaultColumnWidth: FixedColumnWidth(120.0),
                          children: [
                            TableRow(
                              children: [
                                TableCell(child: Padding(
                                  padding: const EdgeInsets.only(top : 10),
                                  child: Text(
                                    item.prodottiDipensa[index].name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                                TableCell(child: IconButton(
                                  alignment: Alignment.topRight,
                                  icon: Icon(Icons.add_shopping_cart),
                                  tooltip: "Prodotto aggiunto alla lista della spesa",
                                  onPressed: () {
                                    getDataService.inserisciProdottoListaSpesa(ListaSpesaEntity( item.prodottiDipensa[index].EAN, item.prodottiDipensa[index].name)).then((value) {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Prodotto aggiunto alla lista della spesa"),
                                      ));
                                    });
                                  },

                                ),),
                                TableCell(child:  IconButton(
                      alignment: Alignment.topRight,
                                  icon: Icon(Icons.restore_from_trash),

                                  tooltip: "Prodotto rimosso dalla dispensa",
                                  onPressed: () {
                                    getDataService.cancellaProdottoDallaDispensa( item.prodottiDipensa[index].EAN).then((value) {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return MyDispensaScreen();
                                          //return tempScreen();
                                        },
                                      ),
                                      );
                                    });
                                  },
                                ),),
                              ]
                            ),

                          ],

                        ),
                      );
                    }
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          );
        }
        return Text("Loading..");
      },
    );
  }
}


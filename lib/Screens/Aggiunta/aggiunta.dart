import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/LaMiaDIspensa/MyDispensaScreen.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/item.dart';
import 'package:smart_cupboard/modal/DispensaEntity.dart';
import 'package:smart_cupboard/modal/ListaSpesaEntity.dart';
import '../../constants.dart';

class AggiuntaProdotto extends StatefulWidget {
  final List<String> prodottiDaCercare = ["Farina", "Latticini", "Verdura", "Frutta"];

  final List<String> listFarina = ["Pane", "Pasta"];


  @override
  _AggiuntaProdottoState createState() => _AggiuntaProdottoState();
}

class _AggiuntaProdottoState extends State<AggiuntaProdotto> {
  GetDataService getDataService = GetDataService();
  Future<List<Item>> _getData;
  List<String> allProductName=[];
  Future<List<DispensaEntity>> allProduct;

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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              getDataService.getAllProduct().then((value) {
                value.forEach((element) {
                  allProductName.add(element.nome);
                  print("LUNGHEZZA Allprod");
                  print(allProductName.length);
                });
                print("VALUEEE");
                print(value);
               //ATTENZIONE NON FUNZIONA
                // showSearch(context: context, delegate: Search(allProductName));
              }
              );
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Cerca prodotto'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: _buildPanel(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  Widget _buildPanel() {
    return FutureBuilder(
      future: _getData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(" DATI " + snapshot.data.toString());
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
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/imgCategorie/" + item.urlImg),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            item.categoryName,
                            style: TextStyle(
                                fontSize: 18,
                                color: Black,
                                backgroundColor: Colors.grey[350],
                                fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, bottom: 5.0),
                        child: new Row(
                          children: <Widget>[
                            Text(
                              item.prodottiDipensa[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              tooltip: "Prodotto aggiunto alla lista della spesa",
                              onPressed: () {
                                getDataService.inserisciProdottoListaSpesa(ListaSpesaEntity( item.prodottiDipensa[index].EAN, item.prodottiDipensa[index].name)).then((value) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Prodotto aggiunto alla lista della spesa"),
                                  ));
                                });
                              },

                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.restore_from_trash),
                              tooltip: "Prodotto rimosso dalla dispensa",
                              onPressed: () {
                                getDataService.cancellaProdottoDallaDispensa( item.prodottiDipensa[index].EAN).then((value) {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AggiuntaProdotto();
                                      //return tempScreen();
                                    },
                                  ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
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

//BOTTOM SHEET
void _settingModalBottomSheet(context) {
  String dropdownValue = 'Farina & derivati';
  Size size = MediaQuery.of(context).size;

  String nomeProdotto;

  GetDataService service = GetDataService();


  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: double.maxFinite,
          height: size.height * 0.4,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
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
                  onChanged: (input) {nomeProdotto = input;},
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
                      'Farina & derivati',
                      'Frutta',
                      'Carne',
                      'Dolci',
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
              RoundedButton(
                text: "Aggiungi alla lista",
                press: (){
                  DispensaEntity d = DispensaEntity(DateTime.now().millisecondsSinceEpoch.toString(), nomeProdotto, dropdownValue);
                  service.inserisciProdotto(d).then((value) {
                    Navigator.pop(context);
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
              ),
            ],
          ),
        );
      });
}

//INIZIO RICERCA
class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;

  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import '../../constants.dart';
import '../../mia_dispensa.dart';

class AggiuntaProdotto extends StatefulWidget {
  final List<String> list = ["Farina", "Latticini", "Verdura", "Frutta"];
  final List<String> listFarina = ["Pane", "Pasta"];

  @override
  _AggiuntaProdottoState createState() => _AggiuntaProdottoState();
}

class _AggiuntaProdottoState extends State<AggiuntaProdotto> {
  List<Item> _books = generateItems(6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(widget.list));
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
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/" + item.urlImg),
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
              shrinkWrap: true, // risolve l'errore pos 12: 'child.hasSize'
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
                      Icon(Icons.add),
                    ],
                  ),
                );
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


//BOTTOM SHEET
void _settingModalBottomSheet(context) {

  String dropdownValue = 'Farina';
  Size size = MediaQuery.of(context).size;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: double.maxFinite,
          height: size.height * 0.4,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: RoundedInputField(
                      hintText: "Inserisci prodotto",
                      icon: null,  //di default ha l'icona user
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0,bottom: 20.0,left: 45.0),
                  child: Text("Seleziona categoria",
                    style:  TextStyle(
                        fontSize: 17, color: Black),
                    ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0,left: 45.0),
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
                      context.setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Farina', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
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
                press: () {},
              ),
            ],
          ),
        );
      });
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.categoryName,
    this.isExpanded = false,
    this.prodottiDipensa,
    this.urlImg,
  });

  String expandedValue;
  String categoryName;
  bool isExpanded;
  String urlImg;
  List<Prodotti> prodottiDipensa;
}

class Prodotti {
  Prodotti({
    this.name,
  });

  String name;
}

List<Item> generateItems(int numberOfItems) {
  List<Item> listItems = [];
  List<Prodotti> listProdotti = [];
  List<dynamic> responseList = CATEGORY_DATA;

  responseList.forEach((post) {
    List<dynamic> prod = post["prodotti"];

    listProdotti = [];

    prod.forEach((element) {
      listProdotti.add(
        new Prodotti(name: element["name"]),
      );
    });

    listItems.add(new Item(
      categoryName: post["name"],
      expandedValue: 'Details for Book  goes where',
      prodottiDipensa: listProdotti,
      urlImg: post["image"],
    ));
  });

  return listItems;
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

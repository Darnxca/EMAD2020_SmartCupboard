
import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/RIcetta/Ricetta_Screen.dart';


class RicercaRicette extends StatefulWidget {
  final List<String> list = ["Farina", "Latticini", "Verdura", "Frutta"];
  final List<String> listFarina = ["Pane", "Pasta"];

  @override
  _myRicercaRicetteState createState() => _myRicercaRicetteState();
}
class _myRicercaRicetteState extends State<RicercaRicette> {
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
        body: InkWell(
          child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, top: 15.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: Image.asset(
                        "assets/images/pollo_alla_cacciatora.jpg",
                        height: 100,
                        width: 120,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                        "Pollo alla cacciatora",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Difficoltà: media",
                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Ricetta_Screen();
                },
              ),
            );
          },
        ),
    );
  }

}

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
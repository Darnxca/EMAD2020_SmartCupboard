import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/Screens/RIcetta/Ricetta_Screen.dart';



class TueRicette extends StatefulWidget {

  @override
  _TueRicetteState createState() => _TueRicetteState();
}

class _TueRicetteState extends State<TueRicette> {

  GetDataService getDataService = GetDataService();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: getDataService.gellAllRicetteChePuoiFare(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print("Errore" + snapshot.error.toString());
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length == 0) {
                  return Text("Ci dispiace, non ci sono ricette riproducibili con i tuoi ingredienti",style: const TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  );
                }
                return snapshot.hasData
                    ? ListView.builder(
                  //serve per far nascondere la lista orizzontale sopra
                    itemCount: snapshot.data.length,
                    //effetto rimbalzo
                    itemBuilder: (context, index) {
                      return Align(
                          heightFactor: 0.7,
                          alignment: Alignment.topCenter,
                          child: InkWell(
                            child: Container(
                                height: 150,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15.0, bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            left: 0.0,
                                              top: 0.0, bottom: 0.0),
                                          child: Image.network(
                                              snapshot.data[index].urlImg,
                                              height: 100,
                                              width: 120)),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(right: 20.0),
                                            child: Text(
                                              snapshot.data[index].nomeRicetta,
                                              //post["name"],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  decoration: TextDecoration.none,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].difficolta,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                decoration: TextDecoration.none,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Ricetta_Screen(ricetta : snapshot.data[index] );
                                  },
                                ),
                              );
                            },
                          ));
                    })
                    : Text("Niente da mostrare!");
              } else {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                );
              }
            }),
    );
  }
}


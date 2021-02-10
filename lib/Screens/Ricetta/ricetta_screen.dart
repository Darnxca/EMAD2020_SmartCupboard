import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/modal/Ricetta.dart';

class Ricetta_Screen extends StatelessWidget {
  @override
  Ricetta ricetta;

  GetDataService getDataService = GetDataService();

  Ricetta_Screen({Key key, @required this.ricetta}) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text('Ricette',style: TextStyle(fontSize: 25.0,color: Color(0xFF000000))),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            ///First show the image in background
            Hero(
              child: Container(
                height: size.height * 0.55,
                child: Image.network(
                  ricetta.urlImg,
                  fit: BoxFit.fill,
                ),
              ),
              tag: "image",
            ),

            ///Container for more content
            DraggableScrollableSheet(
              maxChildSize: 1,
              initialChildSize: 0.6,
              minChildSize: 0.6,
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ricetta.nomeRicetta,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Difficoltà: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                            ),
                            Image.asset("assets/images/"+ricetta.difficolta +".png")
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),

                        ///Container for food information

                        Text(
                          "Ingredienti",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        new Row(children: <Widget>[
                          Expanded(
                              child: SizedBox(
                            height: 150,
                            child: new ListView.builder(
                                itemCount: ricetta.ingredienti.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Icon(Icons.arrow_right),
                                    title: Text(
                                      ricetta.ingredienti[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: null,
                                  );
                                }),
                          )),
                        ]),

                        RoundedButton(
                          text: "Aggiungi alla lista della spesa",
                          press: () {
                            getDataService.inserisciProdottoListaSpesafromRicette(ricetta.ingredienti).then((value) {
                              final snackBar = SnackBar(
                                  content: Text('Ingredienti aggiunti alla lista della spesa'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),

                        Text(
                          "Preparazione",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 4,
                        ),

                        Text(
                          ricetta.procedimento,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

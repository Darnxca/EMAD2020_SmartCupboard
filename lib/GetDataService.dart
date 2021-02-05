import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_cupboard/item.dart';
import 'package:smart_cupboard/modal/ListaSpesaEntity.dart';
import 'package:sqflite/sqflite.dart';
import 'Prodotti.dart';
import 'Screens/LaMiaDIspensa/MyDispensaScreen.dart';
import 'SingletonDatabaseConnection.dart';
import 'modal/DispensaEntity.dart';
import 'modal/Ricetta.dart';
import 'modal/Utente.dart';


class GetDataService {
  DatabaseReference dbRef;
  DispensaEntity result;
  Ricetta ricetta;
  Future<Database> database;
  final FirebaseAuth auth = FirebaseAuth.instance;

  GetDataService() {}

  Future getProdottiFromFirebase(String codice, BuildContext context) async {
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti/" + codice));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        result = DispensaEntity(
            codice, snapshot.value["nome"], snapshot.value["categoria"]);
        print("FIREBASE: " + result.toString());


        // aspetto che venga inserito il prodotto nel database Per ricaricare la pagina
        insertProdottoDispensa(result).then((value){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return MyDispensaScreen();
            },
          ),
          );
        });
      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");
      }
    });
  }
  // ignore: missing_return
  Future<Utente> getUtente() async {
    Utente u ;

    await FirebaseDatabase.instance
        .reference()
        .child("Utente/" + auth.currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      try {
        u = Utente(snapshot.value["nome"], snapshot.value["Cognome"],
            auth.currentUser.email.toString(), auth.currentUser.uid.toString());
      } on NoSuchMethodError catch (e) {
        print("Utente non trovato");
      }
    });

    return u;
  }

  void changePassword(String oldpass,String password,BuildContext context) async{
    //Create an instance of the current user.

    var authCredential = EmailAuthProvider.credential(email: auth.currentUser.email, password: oldpass);

    try {
      var result = await auth.currentUser.reauthenticateWithCredential(
          authCredential);

    }catch(e){
      print(e);
    }
    //Pass in the password to updatePassword.
    auth.currentUser.updatePassword(password).then((_){
      print("Successfully changed password");

      FirebaseAuth.instance.signOut();
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<void> insertProdottoDispensa(DispensaEntity d) async {
    final Database db = await SingletonDatabaseConnection.instance.database;

    await db.insert(
      'Dispensa',
      d.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DispensaEntity>> getDispensa() async {
    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('Dispensa');

    return List.generate(maps.length, (i) {
      return DispensaEntity(
        maps[i]['key_EAN'],
        maps[i]['nome'],
        maps[i]['categoria'],
      );
    });
  }

  Future<List<Item>> getDispensa2() async {
    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> categorie =
        await db.rawQuery('SELECT DISTINCT categoria FROM Dispensa');

    final List<Map<String, dynamic>> prodotti =
        await db.rawQuery('SELECT * FROM Dispensa ORDER BY categoria');


    List<Item> items=[];


    for (int i = 0; i < categorie.length; i++) {
      List<Prodotti> listProdotti = [];

      for (int j = 0; j < prodotti.length; j++) {
        if (prodotti[j]['categoria'] == categorie[i]['categoria']) {
         listProdotti.add(new Prodotti(EAN: prodotti[j]["key_EAN"],name: prodotti[j]['nome']));
        }
      }
      items.add(new Item(
        categoryName: categorie[i]['categoria'],
        expandedValue: 'Details for Book  goes where',
        prodottiDipensa: listProdotti,
        urlImg: categorie[i]['categoria'].toLowerCase()+".png",
      ));
      print(categorie[i]['categoria'].toLowerCase().replaceAll(new RegExp(r"\s+"), "")+".png");
    }


    return items;
  }


  Future<List<Item>> inserisciProdotto(DispensaEntity d) async {
    Database db = await SingletonDatabaseConnection.instance.database;

    await db.insert(
      'Dispensa',
      d.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DispensaEntity>> getAllProduct() async {

    List<DispensaEntity> allProduct = [];
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti" ));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key,values) {
          result = DispensaEntity(key, values["nome"], values["categoria"]);
          print("FIREBASE: " + result.toString());
          allProduct.add(result);
        });
        return allProduct;
      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");
        return allProduct;
      }
    });
  }

  // ignore: missing_return
  Future<List<Ricetta>> gellAllRicetteChePuoiFare() async {

    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> maps = await db.query('Dispensa');
    List<String> ingDispensa =  List.generate(maps.length, (i) {
      return maps[i]['nome'].toString().toLowerCase();
    });

    ingDispensa.forEach((element) {
      print(element);
    });

    List<Ricetta> allRicette = [];
    await FirebaseDatabase.instance
        .reference()
        .child("Ricette")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        List<String> ingredienti = []; //ingredienti della singola ricetta
        Map<dynamic,dynamic> i = values["Ingredienti"];
        i.forEach((key, value) {
          ingredienti.add(value);
        });

        bool flag = true;
        for(int j = 0; j< ingredienti.length;j++){
          if (!ingDispensa.contains(ingredienti[j].toLowerCase())){
            flag = false;
          }
        }

        if(flag) {
          ricetta = Ricetta(values["NomeRicetta"], values["Difficolta"],
              values["Procedimento"], values["urlImg"], ingredienti,values["healthy"]);

          allRicette.add(ricetta);
        }
      });
        });
    return allRicette;
  }


  // ignore: missing_return
  Future<List<Ricetta>> gellAllRicette() async {
    List<Ricetta> allRicette = [];
    await FirebaseDatabase.instance
        .reference()
        .child("Ricette")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        List<String> ingredienti = [];
        Map<dynamic,dynamic> i = values["Ingredienti"];
        i.forEach((key, value) {
          ingredienti.add(value);
        });
        ricetta = Ricetta(values["NomeRicetta"], values["Difficolta"],
            values["Procedimento"], values["urlImg"], ingredienti,values["healthy"]);
        allRicette.add(ricetta);
      });
        });
    return allRicette;
  }

  // ignore: missing_return
  Future<List<Ricetta>> gellAllRicetteHealthy() async {
    List<Ricetta> allRicette = [];
    await FirebaseDatabase.instance
        .reference()
        .child("Ricette")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        List<String> ingredienti = [];
        Map<dynamic,dynamic> i = values["Ingredienti"];
        i.forEach((key, value) {
          ingredienti.add(value);
        });
        if(values["healthy"] == true) {
          ricetta = Ricetta(values["NomeRicetta"], values["Difficolta"],
              values["Procedimento"], values["urlImg"], ingredienti,
              values["healthy"]);
          allRicette.add(ricetta);
        }
      });
    });
    return allRicette;
  }


  Future<List<Item>> inserisciProdottoListaSpesa(ListaSpesaEntity d) async {
    Database db = await SingletonDatabaseConnection.instance.database;

    await db.insert(
      'ListaSpesa',
      d.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> categorie =  await db.rawQuery('SELECT * FROM ListaSpesa');

    categorie.forEach((element) {
      print(element.toString());
    });


  }

  Future<void> cancellaProdottoDallaDispensa(String ean) async {
    Database db = await SingletonDatabaseConnection.instance.database;

    await db.delete('Dispensa', where: 'key_EAN = ?' , whereArgs: [ean]);


    final List<Map<String, dynamic>> categorie =  await db.rawQuery('SELECT * FROM Dispensa');

    categorie.forEach((element) {
      print(element.toString());
    });
  }


  Future<List<Prodotti>> getListaSpesa() async{
    Database db = await SingletonDatabaseConnection.instance.database;

    final List<Map<String, dynamic>> lista = await db.rawQuery('SELECT * FROM ListaSpesa');

    List<Prodotti> listaSpesa=[];

    for(int i =0 ; i< lista.length;i++){
      listaSpesa.add(new Prodotti(name: lista[i]["nome"],EAN :lista[i]["key_EAN"]));
      print(listaSpesa[i].toString());
    }
    return listaSpesa;
  }

  Future<void> removeProductFromListaSpesa(String Ean) async{
    Database db = await SingletonDatabaseConnection.instance.database;

    await db.delete('ListaSpesa', where: 'key_EAN = ?' , whereArgs: [Ean]);
  }


  Future <void> removeAllFromListaSpesa() async{
    Database db = await SingletonDatabaseConnection.instance.database;

    await db.delete('ListaSpesa');
  }

}

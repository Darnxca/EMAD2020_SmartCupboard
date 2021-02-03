import 'package:firebase_database/firebase_database.dart';
import 'package:smart_cupboard/item.dart';
import 'package:smart_cupboard/modal/ListaSpesaEntity.dart';
import 'package:sqflite/sqflite.dart';
import 'Prodotti.dart';
import 'SingletonDatabaseConnection.dart';
import 'modal/DispensaEntity.dart';
import 'modal/Ricetta.dart';

class GetDataService {
  DatabaseReference dbRef;
  DispensaEntity result;
  Ricetta ricetta;
  Future<Database> database;

  GetDataService() {}

  Future getProdottiFromFirebase(String codice) async {
    dbRef = (await FirebaseDatabase.instance
        .reference()
        .child("Prodotti/" + codice));

    dbRef.once().then((DataSnapshot snapshot) {
      try {
        result = DispensaEntity(
            codice, snapshot.value["nome"], snapshot.value["categoria"]);
        print("FIREBASE: " + result.toString());

        insertProdottoDispensa(result);
      } on NoSuchMethodError catch (e) {
        print("Prodotto non trovato");
      }
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
        ingredienti.add("pollo");
        ricetta = Ricetta(values["NomeRicetta"], values["Difficolta"],
            values["Procedimento"], values["urlImg"], ingredienti);
        // print("FIREBASE: " + ricetta.toString());
        allRicette.add(ricetta);
      });

       allRicette.forEach((element) {print(element.toString());});
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

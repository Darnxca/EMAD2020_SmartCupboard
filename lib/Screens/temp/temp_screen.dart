import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_cupboard/GetDataService.dart';
import 'package:smart_cupboard/modal/DispensaEntity.dart';
import 'package:smart_cupboard/modal/Prodotto.dart';

class tempScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GetDataService getDataService = GetDataService();
  var dati;
  DispensaEntity dispensa;
  Prodotto result;

  @override
  void initState() {
    super.initState();
    // connessione al database
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: getDataService.getDispensa(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(" DATI " + snapshot.data.toString());
            if (snapshot.hasError) {
              print("Errore" + snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].nome),
                    subtitle: Text(snapshot.data[index].categoria),
                    /*onTap: () {

                         Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                      );*/
                  );
                },
              );
            }
            return Text("Loading..");
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(user.name),
    ));
  }
}

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}

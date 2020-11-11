import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/Aggiunta/aggiunta.dart';
import 'package:smart_cupboard/Screens/ListaSpesa/lista_spesa.dart';
import 'package:smart_cupboard/Screens/Profilo/profilo.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/ricerca_ricette.dart';
import 'package:smart_cupboard/constants.dart';
import 'package:smart_cupboard/Screens/Login/login_screen.dart';

class MainDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            image: new ExactAssetImage('assets/images/user.jpg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Text('Nome Utente',
                      style: TextStyle(
                        fontSize: 22,
                        color: White,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                'La mia dispensa',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
                onTap: (){   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AggiuntaProdotto();
                    },
                  ) ,
                );
                }
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                'Lista della spesa',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListaSpesa();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                'Ricette',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
                onTap: (){   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RicercaRicette();
                    },
                  ) ,
                );
                }
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                'Profilo',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profilo();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        )


    );
  }
}
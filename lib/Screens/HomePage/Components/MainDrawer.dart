import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';
import 'package:smart_cupboard/Screens/LaMiaDIspensa/MyDispensaScreen.dart';
import 'package:smart_cupboard/Screens/ListaSpesa/lista_spesa.dart';
import 'package:smart_cupboard/Screens/Profilo/profilo.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/ricerca_ricette.dart';
import 'package:smart_cupboard/constants.dart';
import 'package:provider/provider.dart';

import '../../../AuthenticationService.dart';

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
                      width: 130,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            image: new ExactAssetImage('assets/images/logoBN.png'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Benvenuto',
                        style: TextStyle(
                          fontSize: 18,
                          color: White,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Vai alla home',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: (){   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ) ,
                );
                }
            ),
            ListTile(
              leading: Icon(Icons.fastfood ),
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
                      return MyDispensaScreen();
                    },
                  ) ,
                );
                }
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list ),
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
              leading: Icon(Icons.menu_book),
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
              leading: Icon(Icons.person),
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
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: (){
                context.read<AuthenticationService>().signOut(context);
              },
            ),
          ],
        )
    );
  }
}
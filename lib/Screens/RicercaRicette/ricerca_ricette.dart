import 'package:flutter/material.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/components/ricetteHealthy.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/components/tueRicette.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/components/tutteLeRicette.dart';

import '../../GetDataService.dart';

class RicercaRicette extends StatefulWidget {
 

  @override
  _myRicercaRicetteState createState() => _myRicercaRicetteState();
}

class _myRicercaRicetteState extends State<RicercaRicette> {
  GetDataService getDataService = GetDataService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.orange,
              title: Text('Ricette'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Che puoi fare'),
                  Tab(
                    text: 'Tutte',
                  ),
                  Tab(text: 'Healthy'),
                ],
              ),
            ),
            body: TabBarView(
              children: [TueRicette(),  TutteLeRicette(), RicetteHealthy()],
            ),
          ),
        ),
      );
  }
}

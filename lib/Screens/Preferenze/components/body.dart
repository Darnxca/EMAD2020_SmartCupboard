import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';
import 'package:smart_cupboard/Screens/Login/components/background.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/ricerca_ricette.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Body extends StatefulWidget {

  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FlutterLocalNotificationsPlugin localNotification;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  TimeOfDay _timeMattina,_timeSera;

  @override
  void initState() {
    tz.initializeTimeZones();
    var androidInitialize = new AndroidInitializationSettings("mipmap/ic_launcher");

    var IOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: IOSInitialize);

    localNotification = new FlutterLocalNotificationsPlugin();

    _timeMattina = TimeOfDay.now();
    _timeSera = TimeOfDay.now();

    try {
      localNotification.initialize(initializationSettings, onSelectNotification: selectNotification );


    }on MissingPluginException catch (e){
      print(e.message);
    }


    super.initState();
  }

  _pickerTimeMattina() async{
    TimeOfDay timeMattina = await showTimePicker(context: context, initialTime: _timeMattina,
        builder: (BuildContext context, Widget child){
          return Theme(data: ThemeData(),child: child,);
        }
    );

    if(timeMattina != null){
      setState(() {
        _timeMattina = timeMattina;
      });
    }
  }

  _pickerTimeSera() async{
    TimeOfDay timeSera = await showTimePicker(context: context, initialTime: _timeSera,
        builder: (BuildContext context, Widget child){
          return Theme(data: ThemeData(),child: child,);
        }
    );

    if(timeSera != null){
      setState(() {
        _timeSera = timeSera;
      });
    }
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => RicercaRicette()),
    );
  }

  Future showNotification(TimeOfDay mattina, TimeOfDay sera) async{
    var andriodDetaild = new AndroidNotificationDetails("channelId", "LocalNotification", " FUNZIONERà????",importance: Importance.high);

    var iOSDetails = new IOSNotificationDetails();

    var generalNotificationDetails = new NotificationDetails(android: andriodDetaild, iOS: iOSDetails);


    final now = new DateTime.now();
    DateTime d =  new DateTime(now.year, now.month, now.day, _timeMattina.hour, _timeMattina.minute);

    DateTime d1 =  new DateTime(now.year, now.month, now.day, _timeSera.hour, _timeSera.minute);
    await localNotification.zonedSchedule(0, "SmartCupboard: Pranzo", "Ehi... è ora di pranzare accedi per visualizzare le ricette che puoi fare.", tz.TZDateTime.from(d, tz.local).add(Duration (seconds: 5)), generalNotificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);
    await localNotification.zonedSchedule(1, "SmartCupboard: Cena", "Ehi... è ora di cenare accedi per visualizzare le ricette che puoi fare.", tz.TZDateTime.from(d1, tz.local).add(Duration (seconds: 5)), generalNotificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidAllowWhileIdle: true);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "PREFERENZE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Image(image: AssetImage('assets/images/logo.png'),
              height: size.height * 0.35,),
            SizedBox(height: size.height * 0.02),
            Text(
              "A che ora pranzi solitamente?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text('Orario selezionato:\t\t\t\t\t ${_timeMattina.hour}:${_timeMattina.minute}'),
                trailing: Icon(Icons.timer),
                onTap: _pickerTimeMattina,
              ),
            ),
            Text(
              "A che ora ceni solitamente?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text('Orario selezionato:\t\t\t\t\t ${_timeSera.hour}:${_timeSera.minute}'),
                trailing: Icon(Icons.timer),
                onTap: _pickerTimeSera,
              ),
            ),
            RoundedButton(
              text: "Invia",
              press: () {
                showNotification(_timeMattina,_timeSera).then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                ));
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }


}

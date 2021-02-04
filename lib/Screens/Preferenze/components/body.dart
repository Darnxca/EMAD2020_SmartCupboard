import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_cupboard/Screens/HomePage/home_page.dart';
import 'package:smart_cupboard/Screens/Login/components/background.dart';
import 'package:smart_cupboard/Screens/RicercaRicette/ricerca_ricette.dart';
import 'package:smart_cupboard/Screens/Ricetta/ricetta_screen.dart';
import 'package:smart_cupboard/components/rounded_button.dart';
import 'package:smart_cupboard/components/rounded_input_field.dart';


class Body extends StatefulWidget {

  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FlutterLocalNotificationsPlugin localNotification;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings("mipmap/ic_launcher");

    var IOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: IOSInitialize);

    localNotification = new FlutterLocalNotificationsPlugin();
    try {
      localNotification.initialize(initializationSettings, onSelectNotification: selectNotification );
    }on MissingPluginException catch (e){
      print(e.message);
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

  Future showNotification() async{
    var andriodDetaild = new AndroidNotificationDetails("channelId", "LocalNotification", " FUNZIONERà????",importance: Importance.high);

    var iOSDetails = new IOSNotificationDetails();

    var generalNotificationDetails = new NotificationDetails(android: andriodDetaild, iOS: iOSDetails);

    await localNotification.show(0, "Asfenazza", "body della notifica", generalNotificationDetails);
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
            RoundedInputField(
              hintText: "inserisci orario",
              onChanged: (value) {},
            ),
            Text(
              "A che ora ceni solitamente?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RoundedInputField(
              hintText: "inserisci orario",
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Invia",
              press: () {
                showNotification();
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );*/
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }


}

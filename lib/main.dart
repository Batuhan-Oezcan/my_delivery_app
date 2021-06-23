//Material App
import "package:flutter/material.dart";

//Home-Screen:
import 'package:delivery_app/StartSeite.dart';

//Für das setzen der Handy Orientierung
import "package:flutter/services.dart";


//Alle Screens, für das Initialisieren der Routes
import "package:delivery_app/WarenkorbSeite.dart";
import "package:delivery_app/BestellenSeite.dart";
import "package:delivery_app/OeffnungszeitenSeite.dart";
import "package:delivery_app/LieferOrteSeite.dart";
import "package:delivery_app/NewsSeite.dart";
import "package:delivery_app/MeineBestellungenSeite.dart";
import "package:delivery_app/LieferkostenSeite.dart";
import "package:delivery_app/BewertungSeite.dart";
import "package:delivery_app/AGBsSeite.dart";
import "package:delivery_app/ÜberUnsSeite.dart";


//main Funktion (Future main() asnyc, da Portrait einstellungen!)
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]).then((_) => runApp(new DeliveryApp()));

}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Delivery App",
      //theme: AppThemeData(context),
      debugShowCheckedModeBanner: false,
      home: StartSeite(),

    );
  }
}
import "package:flutter/material.dart";
import "package:delivery_app/stuff/konstanten.dart";


ThemeData AppThemeData(BuildContext context) {
  double ts = getTextScale(context);
  return ThemeData(

    iconTheme: IconThemeData(
        size: ts*32,
        color: sekundaerFarbe
    ),

    canvasColor: sekundaerFarbe,
    fontFamily: "Roboto",

    textTheme: TextTheme(
      //Drawer Font:
      bodyText1: TextStyle(fontSize: 16.0 * ts, color:primaerFarbe),
      //Button font:
      button: TextStyle(fontSize: 16 * ts),
      //Body Fonts:
      bodyText2: TextStyle(fontSize: 16 * ts, color: sekundaerFarbe),
      //Unterschrifften Schrift:
      subtitle1: TextStyle(fontSize: 12 * ts, color: sekundaerFarbe),
    ),

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          size: ts * 20,
          color: sekundaerFarbe,
      ),

      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: ts * 20,
            color: sekundaerFarbe,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}

Theme themed(BuildContext context, Widget child) {
  return Theme(
    data: AppThemeData(context),
    child: child
  );
}

//gibt den Textscale des Bildschrims zurück!
double getTextScale(BuildContext context) {
  return MediaQuery.of(context).size.width / 320;
}



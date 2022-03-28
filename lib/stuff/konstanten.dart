import "package:flutter/material.dart";

//Fabrkonstanten
Color primaerFarbe = Colors.yellow.shade800;
Color sekundaerFarbe = Colors.black;
Color tertierFarbe = Colors.red.shade800;
Color splashColor = Colors.yellow.shade800.withOpacity(0.6);

//Textkonstanten
String laden_name = "Papii's Pizza";


List<String> wochentage = [
  "Montag",
  "Dienstag",
  "Mittwoch",
  "Donnerstag",
  "Freitag",
  "Samstag",
  "Sonntag"
];

Map<String, List<String>> oeffnungszeiten = {
  "Montag":["11:00", "23:50"],
  "Dienstag": ["16:30", "01:00"],
  "Mittwoch": ["16:30", "01:00"],
  "Donnerstag": ["16:30", "01:00"],
  "Freitag": ["16:30", "01:00"],
  "Samstag": ["16:00", "01:00"],
  "Sonntag": ["14:45", "00:00"],
};

//Keys für shared Preferences
String lieferKey = "lieferKey";
String abholKey = "abholKey";

List<String> speisen = [
  "Vorspeisen",
  "Hauptspeisen",
  "Beilagen",
  "Sonstiges"
];

Map <String, List<String>> speisen_info = {
  "Vorspeisen" : ["Salate", "Suppen", "Peperoni"],
  "Hauptspeisen" : ["Pizza", "Burger", "Pasta", "Panini"],
  "Beilagen" : ["Dips","Pommes", "Fingerfood"],
  "Sonstiges" : ["Softdrinks", "Desserts"]
};


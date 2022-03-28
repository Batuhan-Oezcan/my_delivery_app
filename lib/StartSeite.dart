import 'package:delivery_app/LieferOrteSeite.dart';
import "package:flutter/material.dart";

//App Spezialsierungen und Ampassugnen
import 'package:delivery_app/stuff/konstanten.dart';
import "package:delivery_app/layout/themeData.dart";
import "package:delivery_app/Drawer.dart";

//Persistenter App Speicher
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";
import "package:flutter_svg/flutter_svg.dart";
//Screens
import "OeffnungszeitenSeite.dart";
import "BestellenSeite.dart";
import "package:flutter_custom_clippers/flutter_custom_clippers.dart";


class StartSeite extends StatefulWidget {
  @override
  _StartSeiteState createState() => _StartSeiteState();
}

class _StartSeiteState extends  State<StartSeite> {
  //Für lokalen persistenten App Speicher
  late SharedPreferences _prefs;

  late bool _openBool;
  late bool _closedBool;

  late String _weekday;
  late int _hour;
  late int _minute;

  bool _lieferButtonBool = true;
  bool _abholButtonBool = false;


  //init Methode...
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => this._prefs = prefs);
      //Abhollieferbuttons Preferenzen laden...
      _getAbholLieferPrefrenzen();
    });
    _checkOpenClose();

  }

    //Builden des Screens...
    @override
    Widget build(BuildContext context) {
      //relativer Text und Icon Faktor, für relativen Bezug
      double ts = getTextScale(context);

      //Ganzer Scaffold wird von themed umhüllt, Icons und Texte werden verallgemeinert
      return themed(
        context,

        Scaffold(
          //Beginn der AppBar, hat immernur title und und endDrawer
          appBar: AppBar(
            leading: Icon(Icons.fastfood_sharp),
            title: Text(laden_name),
            centerTitle: true,
          ),

          //Ruft allgemein definierten Drawer auf, Überall gleich!
          endDrawer: buildDrawer(context),

          //Add Button, als FloatingActionButton
          floatingActionButton: FloatingActionButton(
            splashColor: splashColor,
            child: Icon(Icons.add_sharp, color: sekundaerFarbe, size: ts * 32),
            backgroundColor: primaerFarbe,
            onPressed: () =>
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BestellenSeite())),
          ),
          //Wird in die BottomAppBar gedockt
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,

          //Body wird in einer eigenen Funktion verpackt(_start())
          body: _start(context),

          //BottomNavigationBar, wird in einer sepraten Funktion aufgerufen
          bottomNavigationBar: _bottomNavigationBar(context),
        ),
      );
    }

    //Funktion für den Body
    Widget _start(BuildContext context) {
      double ts = getTextScale(context);
      double height = MediaQuery
          .of(context)
          .size
          .height;
      double width = MediaQuery
          .of(context)
          .size
          .width;


      return Stack(
        children: <Widget>[
          // Image(
          //     image: AssetImage("assets/images/logo.jpeg"),
          //     width: width,
          //     height: height * 0.6,
          //     fit: BoxFit.fill
          // ),

          Padding(
              padding: EdgeInsets.only(top:height*0.1, left:width*0.26, right: width*0.26),
              child: SizedBox(
                  width:width*0.48,height:height*0.45,
                  child:Container(color: primaerFarbe,))),
      Padding(
        padding: EdgeInsets.only(top:height*0.1, left:width*0.25, right: width*0.25)
          ,child:SvgPicture.asset(
      "assets/images/logo_svg.svg",width:width*0.5,height:height*0.45,fit:BoxFit.fill,color:sekundaerFarbe,)),
Padding(
  padding: EdgeInsets.only(top:height*0.05,left:width*0.35),
  child:SizedBox(
      width: width * 0.3,
      height: height * 0.05,
      child:ClipPath(
      clipper: MovieTicketBothSidesClipper(),
      child: Container(color: primaerFarbe,
      child:Center(child: Text(_lieferButtonBool ? "10% Rabatt" : "20% Rabatt")),
      ),
      ),
),),


          Padding(
            padding: EdgeInsets.only(top: height * 0.6, left:width*0.05),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <SizedBox>[
                SizedBox(
                  width: width * 0.35,
                  height: height * 0.25,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <SizedBox>[
                      SizedBox(
                        width: width * 0.35,
                        height: height * 0.05,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color:primaerFarbe)
                            ),
                          splashColor: splashColor,
                            onPressed: () async{
                              if (!_lieferButtonBool) {
                                setState(() async {
                                  _lieferButtonBool = !_lieferButtonBool;
                                  _abholButtonBool = !_abholButtonBool;
                                  await _prefs.setBool(
                                      lieferKey, _lieferButtonBool);
                                  await _prefs.setBool(
                                      abholKey, _abholButtonBool);
                                  _getAbholLieferPrefrenzen();
                                });
                              }
                            },

                            color: _lieferButtonBool
                                ? primaerFarbe
                                : sekundaerFarbe,
                            textColor: _lieferButtonBool
                                ? sekundaerFarbe
                                : primaerFarbe,
                            child: Center(child: Text("Liefern"))
                        ),
                      ),
                      SizedBox(
                        width: width * 0.35,
                        height: height * 0.05,
                        child: FlatButton(
                          splashColor: splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color:primaerFarbe)
                            ),
                            onPressed: () async{
                              if (!_abholButtonBool) {
                                setState(() async {
                                  _abholButtonBool = !_abholButtonBool;
                                  _lieferButtonBool = !_lieferButtonBool;
                                  await this._prefs.setBool(
                                      abholKey, _abholButtonBool);
                                  await this._prefs.setBool(
                                      lieferKey, _lieferButtonBool);
                                  _getAbholLieferPrefrenzen();
                                });
                              }
                            },
                            color: _abholButtonBool
                                ? primaerFarbe
                                : sekundaerFarbe,
                            textColor: _abholButtonBool
                                ? sekundaerFarbe
                                : primaerFarbe,
                            child: Center(child: Text("Abholen"))
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.625, right:width*0.05),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                      Row(
                        mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                        width: width * 0.175,
                        height: height * 0.1,
                        child: ClipPath(
                          clipper: OctagonalClipper(),
                          child: Container(color: _openBool ? Colors.green: Colors.green.withOpacity(0.2),
                            child:Center(child: Text("OPEN")),
                          ),
                        ),
                      ),
                        SizedBox(
                          width: width * 0.175,
                          height: height * 0.1,
                          child: ClipPath(
                            clipper: OctagonalClipper(),
                            child: Container(color: _openBool ? Colors.red.withOpacity(0.2):Colors.red,
                              child:Center(child: Text("CLOSE")),
                            ),
                          ),
                        ),])]))
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // Padding(
          //   padding: EdgeInsets.only(top: height * 0.6, right:width*0.05),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <SizedBox>[
          //       SizedBox(
          //         width: width * 0.35,
          //         height: height * 0.25,
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           mainAxisSize: MainAxisSize.min,
          //           children: <SizedBox>[
          //             SizedBox(
          //               width: width * 0.35,
          //               height: height * 0.05,
          //               child: DecoratedBox(
          //                 decoration: ShapeDecoration(
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(ts * 0)),
          //                   color: _openBool ? Colors.green : Colors.red,
          //                 ),
          //                 child: Center(
          //                   child: Text(_openBool ? "Geöffnet" : "Geschlossen",
          //                     style: TextStyle(color: sekundaerFarbe),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               width: width * 0.35,
          //               height: height * 0.05,
          //               child: DecoratedBox(
          //                 decoration: ShapeDecoration(
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(ts * 0)),
          //                   color: sekundaerFarbe,
          //                 ),
          //                 child: Center(
          //                   child: Text(_lieferButtonBool ? "10% Rabatt" : "20% Rabatt",
          //                     style: TextStyle(color: _openBool ? Colors.green : Colors.red),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    }

    //Funktion für Den BottomNavigationbar
    Widget _bottomNavigationBar(BuildContext context) {
      //text/Icon Faktor
      double ts = getTextScale(context);

      //Displaygrößen:
      double height = MediaQuery
          .of(context)
          .size
          .height;

      return SizedBox(
        height: height * 0.15,
        child: BottomAppBar(
          color: primaerFarbe,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              //Anrufen
              FlatButton(
                splashColor: splashColor,
                onPressed: () {
                  launch("tel://015901156555");
                },
                child: Center(
                    child: Icon(Icons.phone_sharp)
                ),
              ),

              //Öffnungszeiten
              FlatButton(
                splashColor: splashColor,
                onPressed: () =>
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OeffnungszeitenSeite())),
                child: Center(
                    child: Icon(Icons.access_time_filled_sharp)
                ),
              ),

              //Einkaufswagen
              FlatButton(
                splashColor: splashColor,
                onPressed: () {},
                child: Center(
                    child: Icon(Icons.shopping_cart_sharp)
                ),
              ),

              //Standort <-> Lieferorte
              FlatButton(
                splashColor: splashColor,
                onPressed: () =>
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LieferOrteSeite())),
                child: Center(
                    child: Icon(Icons.location_on_sharp)
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _getAbholLieferPrefrenzen() {
      setState(() {
        _lieferButtonBool = _prefs.getBool(lieferKey) ?? true;
        _abholButtonBool = _prefs.getBool(abholKey) ?? false;
      });
    }

    void _checkOpenClose() {
      //zeit daten getten
      _weekday = wochentage[DateTime.now().weekday - 1];
      _hour = DateTime.now().hour<5? DateTime.now().hour+24 : DateTime.now().hour;
      _minute = DateTime.now().minute;

      //abhängig vom Tag, die Özeiten auslesen, 1Uhr=25Uhr, 2uhr=26uhr,etc...
      int openH = int.parse(oeffnungszeiten[_weekday]![0].split(":")[0]);
      openH = openH<5 ? openH+24 : openH;
      int openMin = int.parse(oeffnungszeiten[_weekday]![0].split(":")[1]);

      int closeH = int.parse(oeffnungszeiten[_weekday]![1].split(":")[0]);
      closeH = closeH<5 ? closeH+24 : closeH;
      int closeMin = int.parse(oeffnungszeiten[_weekday]![1].split(":")[1]);

      //checken ob aktuelle Zeit in den Öffnungszeiten liegt, je nachdem auf oder zu
      if (_hour > openH && _hour < closeH ||
          _hour==openH && _minute > openMin ||
          _hour==closeH && _minute < closeMin
      ) {
        _openBool = true;
        _closedBool = false;
      } else {
        _openBool = false;
        _closedBool = true;
      }
    }
  }


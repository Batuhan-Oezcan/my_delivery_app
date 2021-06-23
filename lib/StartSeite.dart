import "package:flutter/material.dart";

//App Spezialsierungen und Ampassugnen
import 'package:delivery_app/stuff/konstanten.dart';
import "package:delivery_app/layout/themeData.dart";
import "package:delivery_app/Drawer.dart";

//Persistenter App Speicher
import "package:shared_preferences/shared_preferences.dart";


class StartSeite extends StatefulWidget {
  @override
  _StartSeiteState createState() => _StartSeiteState();
}

class _StartSeiteState extends  State<StartSeite> {
  //Für lokalen persistenten App Speicher
  late SharedPreferences _prefs;

  //Keys und Values des abhol und liefer button (für sharedPreferences)
  static const String lieferKey = "lieferKey";
  static const String abholKey = "abholKey";
  bool _lieferButtonBool = true;
  bool _abholButtonBool = false;

  //TODO: geöffnet und geschlossen muss von Öffnungszetien abhängen,
  //zu Beginn beim Öffnen der App, soll abgefragt werden ob die momentane Uhrzeit
  //geöffnet oder nicht ist
  bool _openBool = false;
  bool _closedBool = true;

  //init Methode...
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => this._prefs = prefs);
      //Abhollieferbuttons Preferenzen laden...
      _getAbholLieferPrefrenzen();
    });
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
            backgroundColor: primaerFarbe,
            leading: Icon(Icons.fastfood_sharp),
            title: Text(laden_name),
          ),

          //Ruft allgemein definierten Drawer auf, Überall gleich!
          endDrawer: buildDrawer(context),

          //Add Button, als FloatingActionButton
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_sharp,color:sekundaerFarbe,size:ts*32),
              backgroundColor:primaerFarbe,
              onPressed: () {
              },
            ),
          //Wird in die BottomAppBar gedockt
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Stack(
      children: <Widget>[
        Image(
            image: AssetImage("assets/images/logo.jpeg"),
            width: width,
            height: height*0.6,
            fit: BoxFit.fill
        ),

        Padding(
          padding: EdgeInsets.only(top:height*0.6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <SizedBox>[
              SizedBox(
                width: width*0.35,
                height: height*0.25,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <SizedBox>[
                SizedBox(
                width: width*0.35,
                  height: height*0.05,
                  child:FlatButton(
                    onPressed: () {
                      if (!_lieferButtonBool) {
                        setState(() async{
                          _lieferButtonBool = !_lieferButtonBool;
                          _abholButtonBool = !_abholButtonBool;
                          await _prefs.setBool(lieferKey, _lieferButtonBool);
                          await _prefs.setBool(abholKey, _abholButtonBool);
                          _getAbholLieferPrefrenzen();
                        });
                      }
                    },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ts*15)
                    ),
                      color: _lieferButtonBool ? primaerFarbe : sekundaerFarbe,
                      textColor: _lieferButtonBool ? sekundaerFarbe : primaerFarbe,
                      child: Center(child:Text("Liefern"))
                  ),
                ),
                  SizedBox(
                    width: width*0.35,
                    height: height*0.05,
                    child:FlatButton(
                        onPressed: () {
                          if (!_abholButtonBool) {
                            setState(() async {
                              _abholButtonBool = !_abholButtonBool;
                              _lieferButtonBool = !_lieferButtonBool;
                              await this._prefs.setBool(abholKey, _abholButtonBool);
                              await this._prefs.setBool(lieferKey, _lieferButtonBool);
                              _getAbholLieferPrefrenzen();
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ts*15)
                        ),
                        color: _abholButtonBool ? primaerFarbe : sekundaerFarbe,
                        textColor: _abholButtonBool ? sekundaerFarbe : primaerFarbe,
                        child: Center(child:Text("Abholen"))
                    ),
                  )
                ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height*0.6),
          child: Center(
            child: SizedBox(
            width: width*0.25,
            height: height*0.05,

                  child:Center(child:Text(_lieferButtonBool ? "10% Rabatt" : "20% Rabatt",
                  style: TextStyle(
                    fontSize: 14*ts,
                    fontWeight: FontWeight.bold,
                    //Rabatt-Farbe
                    color: Colors.red.shade800
                  ),
                  ),
                ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top:height*0.6),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <SizedBox>[
                SizedBox(
                    width: width*0.35,
                    height: height*0.25,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <SizedBox>[
                          SizedBox(
                          width: width*0.35,
                          height: height*0.05,
                          child:DecoratedBox(
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(ts*15)),
                                color: _openBool ? Colors.green.shade800 : sekundaerFarbe,
                              ),
                              child: Center(
                                  child:Text("Geöffnet",
                                    style: TextStyle(color: _openBool ? sekundaerFarbe : primaerFarbe),
                                  ),
                              ),
                          ),
                          ),
                          SizedBox(
                            width: width*0.35,
                          height: height*0.05,
                          child:DecoratedBox(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ts*15)),
                              color: _closedBool ? Colors.red.shade800 : sekundaerFarbe,
                            ),
                            child: Center(
                              child:Text("Geschlossen",
                                style: TextStyle(color: _closedBool ? sekundaerFarbe : primaerFarbe),
                              ),
                            ),
                          ),
                          ),
                        ],
                    ),
                ),
              ],
          ),
        ),
      ],
    );
  }

  //Funktion für Den BottomNavigationbar
  Widget _bottomNavigationBar(BuildContext context) {
    //text/Icon Faktor
    double ts = getTextScale(context);

    //Displaygrößen:
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height*0.15,
      child: BottomAppBar(
        color: primaerFarbe,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            //Anrufen
            FlatButton(
              onPressed: () {},
              child: Center(
                  child:Icon(Icons.phone_sharp)
              ),
            ),

            //Öffnungszeiten
            FlatButton(
              onPressed: () {},
              child: Center(
                  child:Icon(Icons.access_time_filled_sharp)
              ),
            ),

            //Einkaufswagen
            FlatButton(
              onPressed: () {},
              child: Center(
                  child:Icon(Icons.shopping_cart_sharp)
              ),
            ),

            //Standort <-> Lieferorte
            FlatButton(
              onPressed: () {},
              child: Center(
                  child:Icon(Icons.location_on_sharp)
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getAbholLieferPrefrenzen() {
    setState(() {
      this._lieferButtonBool = this._prefs.getBool(lieferKey) ?? true;
      this._abholButtonBool = this._prefs.getBool(abholKey) ?? false;
    });
  }
}

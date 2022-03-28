import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

//App Spezialsierungen und Ampassugnen
import 'package:delivery_app/stuff/konstanten.dart';
import "package:delivery_app/layout/themeData.dart";
import "package:delivery_app/Drawer.dart";

class OeffnungszeitenSeite extends StatefulWidget {
  @override
  _OeffnungszeitenSeiteState createState() => _OeffnungszeitenSeiteState();
}

class _OeffnungszeitenSeiteState extends State<OeffnungszeitenSeite> {

    late int today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now().weekday - 1;
  }

  @override
  Widget build(BuildContext context) {

    return themed(
        context,
        Scaffold(
          appBar: AppBar(
          title: Text("Öffnungszeiten"),
          centerTitle: true,
          leading: IconButton(
              icon:Icon(Icons.arrow_back),
            splashColor: splashColor,
            onPressed:() => Navigator.pop(context, false)
          ),
          ),
          endDrawer: buildDrawer(context),

          body: _start(context),
        ),
    );
  }

  Widget _start(BuildContext context) {
    double ts = getTextScale(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (int i = 0; i < wochentage.length; i++)
          Center(
            child: Container(
              width: width*0.9,
              height: height*0.11,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: today==i ? sekundaerFarbe: primaerFarbe),
              color: today==i ? primaerFarbe : sekundaerFarbe
              ),
              child: ListTile(
                leading: Icon(
                    Icons.access_time_filled_sharp,
                    size:ts*32,
                    color: today==i ? sekundaerFarbe : primaerFarbe
                ),
                title: Text(
                    wochentage[i],
                    style:TextStyle(
                        fontSize:16*ts,
                        color:today==i ? sekundaerFarbe : primaerFarbe
                    )
                 ),
                subtitle: Text(
                    "${oeffnungszeiten[wochentage[i]]![0]} - ${oeffnungszeiten[wochentage[i]]![1]}",
                    style:TextStyle(
                        fontSize:12*ts,
                        color:today==i ? sekundaerFarbe : primaerFarbe,
                        fontWeight: FontWeight.bold
                    )
                ),
                        ),
            )
          )
      ]
    );
  }
}

import "package:flutter/material.dart";

import 'package:delivery_app/stuff/konstanten.dart';
import "package:delivery_app/layout/themeData.dart";
import "package:delivery_app/Drawer.dart";


class LieferOrteSeite extends StatefulWidget {

  @override
  _LieferOrteSeiteState createState() => _LieferOrteSeiteState();
}


class _LieferOrteSeiteState extends State<LieferOrteSeite> {
  @override
  Widget build(BuildContext context) {

    double ts = getTextScale(context);
    return themed(
      context,
      DefaultTabController(
          length: 2,
          child: Scaffold(

            appBar: AppBar(
              title: Text("Locations"),
              centerTitle: true,
              bottom: TabBar(
                enableFeedback: true,
                labelColor: sekundaerFarbe,
                  indicatorColor: tertierFarbe,
                  tabs: [
                    Tab(
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.delivery_dining_sharp),
                              Text("Lieferorte", style:TextStyle(fontSize:16*ts)),
                            ],
                        ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.home_work_sharp),
                          Text("Standorte", style:TextStyle(fontSize:16*ts)),
                        ],
                      ),
                    ),
                  ],
              ),
            ),
            body: _start(context),

      )
      )
    );
  }

  Widget _start(BuildContext context) {
   return TabBarView(
     children: [Container(),Container()]

   );

  }


}

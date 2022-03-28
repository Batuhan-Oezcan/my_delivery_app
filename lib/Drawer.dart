import "package:flutter/material.dart";
import "package:delivery_app/layout/themeData.dart";
import 'package:flutter_svg/flutter_svg.dart';
import "package:delivery_app/stuff/konstanten.dart";
import "package:delivery_app/StartSeite.dart";

Drawer buildDrawer(BuildContext context) {
  double ts = getTextScale(context);

  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child:
              SvgPicture.asset(
                "assets/images/pizza_logo.svg",
                width:64*ts,
                height:64*ts,
                fit:BoxFit.fill,
                color:primaerFarbe,
              ),
          ),
        ),

        ListTile(
          title: Text("Home"),
          leading: Icon(Icons.home_sharp, color:primaerFarbe, size:ts*16),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => StartSeite())),
        ),

        ListTile(
          title: Text("News"),
          leading: Icon(Icons.new_releases_sharp, color:primaerFarbe, size:ts*16),
        ),

        ListTile(
          title: Text("Bestellungen"),
          leading: Icon(Icons.fastfood_sharp, color:primaerFarbe, size:ts*16),
        ),

        ListTile(
          title: Text("Lieferkosten"),
          leading: Icon(Icons.delivery_dining_sharp, color:primaerFarbe, size:ts*16),
        ),

        ListTile(
          title: Text("Bewerten"),
          leading: Icon(Icons.thumb_up_sharp, color:primaerFarbe, size:ts*16),
        ),

        ListTile(
          title: Text("AGBs"),
          leading: Icon(Icons.copyright_sharp, color:primaerFarbe, size:ts*16),
        ),

        ListTile(
          title: Text("Über"),
          leading: Icon(Icons.person_sharp, color:primaerFarbe, size:ts*16),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share_sharp, color:primaerFarbe, size:ts*16),

        ),

      ],
    ),
  );
}

class Seite extends StatelessWidget {
  const Seite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
        body: Container(child:Center(child:Text("HALLO!"))));
  }
}

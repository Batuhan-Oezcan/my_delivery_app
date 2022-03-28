import "package:flutter/material.dart";
import "package:delivery_app/layout/themeData.dart";
import "package:delivery_app/stuff/konstanten.dart";
import "package:delivery_app/Drawer.dart";
import "package:delivery_app/LieferOrteSeite.dart";

class BestellenSeite extends StatefulWidget {

  @override
  _BestellenSeiteState createState() => _BestellenSeiteState();
}

class _BestellenSeiteState extends State<BestellenSeite> {

  late List<String> info;


  @override
  Widget build(BuildContext context) {
    return themed(
        context,

        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon:Icon(Icons.arrow_back),
                  splashColor: splashColor,
                  onPressed:() => Navigator.pop(context, false)
              ),
              title: Text("Bestellen"),
              centerTitle: true,
            ),
            endDrawer: buildDrawer(context),

          body: _start(context),
        ),
    );
  }

  Widget _start(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: speisen.length,
        itemBuilder: (context, index) {
        info = speisen_info[speisen[index]]!;
        return Column(
            children:[
              Text(
                  "${speisen[index]}:",
                  style:(TextStyle(color:primaerFarbe,fontWeight: FontWeight.bold))
              ),
              Container(
                margin: EdgeInsets.only(
                    top:height*0.00,
                    bottom: height*0.05,
                    left:width*0.02,
                    right:width*0.02),
                height: height*0.3,

                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: info.length,
                    itemBuilder: (context,index){
                      return SizedBox(
                          width: width*0.3,
                          child:Card(
                            color: sekundaerFarbe,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color:primaerFarbe)
                            ),
                            child: InkWell(
                              onTap: (){},
                                splashColor: Colors.yellow.shade800.withOpacity(0.4),
                              child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    "assets/images/${info[index]}.jpg",
                                    width: width*0.3,
                                    height: height*0.2,
                                    fit: BoxFit.fill
                                ),
                                Center(
                                    child: Text(
                                        info[index],
                                        style:TextStyle(color:primaerFarbe)
                                    )
                                ),
                              ],
                            ),
                          ),)
                      );
                }
                ),
              )
            ]
        );
      }
      );
  }
}

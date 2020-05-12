import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(title: new Text("Home"), centerTitle: true),
        drawer: new Sidebar(),
        body:
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                SizedBox(height: 10.0),
                Text("MauMetro", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 260.0,
                  width: 410.0,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: false,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 500),
                    dotSize: 6.0,
                    dotIncreasedColor: Color(0xFFFF335C),
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.bottomCenter,
                    dotVerticalPadding: 10.0,
                    showIndicator: true,
                    indicatorBgPadding: 7.0,
                    images: [
                      ExactAssetImage("assets/metro5.jpg"),
                      ExactAssetImage("assets/metro1.jpg"),
                      ExactAssetImage("assets/metro4.jpg"),
                      ExactAssetImage("assets/metro2.jpg"),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),

                Text("The MauMetro Mobile Application", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text('The MauMetro mobile application aims at helping citizen of '
                    'Mauritius to make better use of Metro by being provided with '
                    'the right information',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
                SizedBox(height: 25.0),
                Text("Features of MauMetro", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                Text("  1. Buy tickets" + "\n" + "  2. Route map showing the location of Metro stations"  + "\n" +
                "  3. View the bought tickets" + "\n" + "  4. Information about the Feeder Bus" + "\n" + "  5. Information about the MECards" +
                "\n" + "  6. Access the emergency contact list in case of any emergency" + "\n" + "  7. Make a complaint" + "\n" +
                    "  8. Read about the guidelines for using Metro", style: new TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),
                Text("Benefits of using MauMetro", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                Text("  1. No need to wait in long queues to buy tickets at the station  " + "\n" + "  2. Easy to calculate the ticket fare prior to taking the trip"  + "\n" +
                    "  3. Find location of the Metro stations" + "\n" + "  4. Find different stops of Feeder Bus according to its route" + "\n" + "  5. Make complaints for any problem encountered" +
                    "\n", style: new TextStyle(fontWeight: FontWeight.bold)),

              ],
            ),
          )
        )
      ),
    );
  }
}

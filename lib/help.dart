import 'package:flutter/material.dart';
import 'sidebar.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Help"),
            centerTitle: true),
        //calling the sidebar
        drawer: new Sidebar(),
      ),
    );
  }
}


//class Help extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Help"),
//            centerTitle: true),
//        //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}
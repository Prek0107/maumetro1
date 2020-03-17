import 'package:flutter/material.dart';
import 'sidebar.dart';

class EmergencyContacts extends StatefulWidget {
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Emergency contacts"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
      ),
    );
  }
}


//class EmergencyContacts extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Emergency contacts"),
//            centerTitle: true
//        ),
//      //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}

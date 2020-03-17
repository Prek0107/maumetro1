import 'package:flutter/material.dart';
import 'sidebar.dart';

class BuyTickets extends StatefulWidget {
  @override
  _BuyTicketsState createState() => _BuyTicketsState();
}

class _BuyTicketsState extends State<BuyTickets> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Buy tickets"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
      ),
    );
  }
}


//class BuyTickets extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Buy tickets"),
//            centerTitle: true
//        ),
//        //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}
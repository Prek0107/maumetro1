import 'package:flutter/material.dart';
import 'sidebar.dart';

class FeederBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Feeder bus"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
      ),
    );
  }
}
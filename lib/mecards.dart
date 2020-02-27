import 'package:flutter/material.dart';
import 'sidebar.dart';

class MeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("MECard"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
      ),
    );
  }
}
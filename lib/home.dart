import 'package:firebase_auth/firebase_auth.dart';
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
      onWillPop: (){
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Home"),
            centerTitle: true
        ),
        drawer: new Sidebar(),
      ),
    );
  }

//  void signOut() async {
//    return FirebaseAuth.instance.signOut();
//  }
}

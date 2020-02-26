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
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      drawer: new Sidebar(),
    );
  }

  void signOut() async {
    return FirebaseAuth.instance.signOut();
  }
}

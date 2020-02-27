//login and sign up options
import 'package:flutter/material.dart';
import 'package:maumetro/signIn_page.dart';
import 'package:maumetro/sign_up.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("MauMetro"),
          centerTitle: true,
          leading: Icon(Icons.directions_subway),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: navigateToSignIn,
              child: Text('Login'),
          ),
            RaisedButton(
              onPressed: navigateToSignUp,
              child: Text('Sign up'),
            ),
          ]
        )
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}

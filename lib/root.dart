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
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(alignment: Alignment.center
            ),
            RaisedButton(
              onPressed: navigateToSignIn,
              child: Text('Login',
                  style: TextStyle(
                      fontSize: 20.0)),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 69.0), //size of button
              color: Colors.blue,
              elevation: 50.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
          ),
            SizedBox(height: 25),
            RaisedButton(
              onPressed: navigateToSignUp,
              child: Text('Sign up',
                  style: TextStyle(
                      fontSize: 20.0)),
              elevation: 50.0,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0), //size of button
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
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

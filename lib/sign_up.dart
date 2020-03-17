//signup page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maumetro/signIn_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  String _email, _password, _fullname, _id;

  //final userId = FirebaseAuth.instance.currentUser();



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false, //to prevent bottom overflow
      appBar: new AppBar(
        title: Text('Sign up to MauMetro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),//space between the textfields
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please enter your full name';
                }
              },
              onSaved: (input) => _fullname = input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Fullname",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 30), //space between the textfields
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please enter your email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 30), //space between the textfields
            TextFormField(
              validator: (input) {
                if(input.length < 10){
                  return 'Please enter a password which is atleast 10 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              obscureText: true, //hide password when typed
            ),
            SizedBox(height: 30), //space between the textfields
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign up',
                  style: TextStyle(
                      fontSize: 20.0)),
              padding: EdgeInsets.symmetric(vertical: 11.0, horizontal: 59.0), //size of button
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              elevation: 24.0, //shadow of button
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
       saveToDatabase();
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }

  void saveToDatabase() async {
    //retrieving the uid from authentication in firebase to save it to the user collection
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid;

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DocumentReference ref = await db.collection('users')
          .add({
        'fullname': '$_fullname',
        'email': '$_email',
        'UID': '$uid'
      });
      setState(() => _id= ref.documentID);
      print(ref.documentID);
    }
  }
}

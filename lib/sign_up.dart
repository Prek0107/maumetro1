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

  void saveToDatabase() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DocumentReference ref = await db.collection('users')
          .add({
        'fullname': '$_fullname',
        'email': '$_email'
      });
      setState(() => _id= ref.documentID);
      print(ref.documentID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Sign up to MauMetro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please enter your full name';
                }
              },
              onSaved: (input) => _fullname = input,
              decoration: InputDecoration(
                  labelText: 'Fullname'
              ),
            ),
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please enter your email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input) {
                if(input.length < 10){
                  return 'Please enter a password which is atleast 10 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true, //hide password when typed
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign up'),
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
}

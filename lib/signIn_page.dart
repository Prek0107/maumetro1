//login page
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maumetro/home.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Password visibility
  bool _isHidden = true;
  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //to prevent bottom overflow
      appBar: AppBar(
        title: Text('Login to Maumetro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Image.asset('assets/logo2.png', height: 150, width: 150,),
            SizedBox(height: 30),
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return "Please your email address";
                }
                return null;
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Email",
                errorStyle: TextStyle(
                  fontSize: 15.0
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                prefixIcon: Icon(Icons.email)
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            TextFormField(
              validator: (input) {
                if(input.length < 10){
                  return "Please enter password of atleast 10 characters ";
              } else {
                  if(input.isEmpty){
                    return "Please enter a password";
                  } return null;
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                errorStyle: TextStyle(
                    fontSize: 15.0
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)
                ),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                ),
              ),
              obscureText: _isHidden ? true : false, //hide or show password when typed
            ),
            SizedBox(height: 30),
            OutlineButton(
              onPressed: signIn,
              child: Text('Login', style: TextStyle(
                  fontSize: 20.0)),
              padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 59.0), //size of button
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              borderSide: BorderSide(color: Colors.red, width: 2),
              //elevation: 24.0, //shadow of button
            ),
          ],
        ),
      ),
    );
  }

  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }catch(e){
        print(e.message);
      }
    }
  }
}
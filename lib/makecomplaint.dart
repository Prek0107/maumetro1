import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MakeComplaint extends StatefulWidget {
  @override
  _MakeComplaintState createState() => _MakeComplaintState();
}

class _MakeComplaintState extends State<MakeComplaint> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  String _complaint, _id;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Make Complaint"),
            centerTitle: true),
        //calling the sidebar
        drawer: new Sidebar(),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Please enter your complaint';
                  }
                },
                onSaved: (input) => _complaint = input,
                decoration: InputDecoration(
                    labelText: 'Fullname'
                ),
              ),
              RaisedButton(
                child: Text('Send complaint'),
                onPressed: () {
                  //Firestore.instance.collection("complaints").document().setData();
              },
              ),
            ],
          ),
        ),
      ),
    );
  }

//  void sendComplaint() async {
//    if(_formKey.currentState.validate()){
//      _formKey.currentState.save();
//      try{
//        await FirebaseAuth.instance.createUserWithEmailAndPassword(complaint: _complaint);
//        saveToDatabase();
//      }catch(e){
//        print(e.message);
//      }
//    }
//  }

  void saveToDatabase() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      DocumentReference ref = await db.collection('complaints')
          .add({
        'UID': '',
        'complaint': '$_complaint',
      });
      setState(() => _id= ref.documentID);
      print(ref.documentID);
    }
  }
}

//class MakeComplaint extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Make Complaint"),
//            centerTitle: true),
//        //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}

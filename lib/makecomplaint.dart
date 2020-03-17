import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maumetro/complaintModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeComplaint extends StatefulWidget {
  @override
  _MakeComplaintState createState() => _MakeComplaintState();
}

class _MakeComplaintState extends State<MakeComplaint> {
final complaintcontroller = TextEditingController();

Future<void> postComplaint(final complaint) async{
  Firestore firestore = Firestore.instance;
  firestore.collection("complaints").add(complaint)
      .then((DocumentReference document) {
        print(document.documentID);
  }).catchError((e) {
    print(e);
  });
}

void saveToDatabase() async {
  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String uid = user.uid;

  final String complaint1 = complaintcontroller.text;
  final String userid = user.uid;
  final Timestamp date = Timestamp.now();

  final ComplaintModel complaints = ComplaintModel(complaint: complaint1, uid: userid, date: date);
  postComplaint(complaints.toMap());

  complaintcontroller.clear(); //clears the text field when the complaint is saved to database
}


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
        body: Column(
            children: <Widget>[
              TextFormField(
                controller: complaintcontroller,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter your complaint';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Write complaint'
                ),
              ),
              RaisedButton(
                child: Text('Send complaint'),
                onPressed: () {

                  return Alert(
                      context: context,
                      title: "Send complaint?",
                      desc: "Are you sure you want to send the complaint?",
                      buttons: [
                        DialogButton(
                          child: Text ("Yes"),
                          onPressed: () {
                            saveToDatabase(); //complaint is saved to database
                            Navigator.pop(context);
                          },
                        ),
                        DialogButton(
                          child: Text ("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ])
                      .show();
                },
              ),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("complaints").orderBy("date", descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if(querySnapshot.hasError)
                      return Text("Some error");

                    if(querySnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{

                      final complaintList = querySnapshot.data.documents;

                      return ListView.builder(
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(complaintList[index]["complaint"]),
                              subtitle: Text(complaintList[index]["date"].toString()),
                            );
                          },
                        itemCount: complaintList.length,
                      );
                      
                    }
                },
                )
              )

            ],
          ),
        ),
      );
  }

}
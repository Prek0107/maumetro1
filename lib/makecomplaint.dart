import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
  //final String uid = user.uid;

  final String complaint1 = complaintcontroller.text;
  final String userid = user.uid;
  final DateTime date = DateTime.now();

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
                  if(complaintcontroller.text == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Please fill in your complaint"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    return Alert(
                        context: context,
                        title: "Send complaint?",
                        desc: "Are you sure you want to send the complaint?",
                        buttons: [
                          DialogButton(
                            child: Text ("Yes"),
                            onPressed: () {
                              saveToDatabase(); //complaint is saved to database
                              Navigator.pop(context); //pops alert dialog box
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Complaint sent"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          DialogButton(
                            child: Text ("No"),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Complaint not sent"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ])
                        .show();
                  }


                },
              ),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("complaints").orderBy("date", descending: true).snapshots(),
                  //stream: Firestore.instance.collection("complaints").orderBy("date", descending: true).where("users", isEqualTo: ).snapshots(),

                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if(querySnapshot.hasError)
                      return Text("Some error");

                    if(querySnapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else{

                      final complaintList = querySnapshot.data.documents;

                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (_, index) => Divider(),
                          itemBuilder: (context, index){
                            return ListTile(
                              title: Text(complaintList[index]["complaint"],
                                style: new TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(DateFormat.yMMMMd().add_jm().format(complaintList[index].data["date"].toDate()).toString(), //yMMMMd: YEAR_MONTH_DAY
                                style: new TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                              ),
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

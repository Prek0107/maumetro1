import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sidebar.dart';

class EmergencyContacts extends StatefulWidget {
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Emergency contacts"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
        body: ContactList(),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

Widget _circularProgressIndicator() {
  return CircularProgressIndicator(); //loading
}

Future getContacts() async {
  //instantiate cloud firestore
  var firestore = Firestore.instance;
  QuerySnapshot q = await firestore.collection("emergency_contacts").getDocuments();
  return q.documents;
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getContacts(),
          builder: (_, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: _circularProgressIndicator(),
              );
            } else {

              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  separatorBuilder: (_, index) => Divider(),
                  itemBuilder: (_, index) {

                    return ListTile(
                      contentPadding: const EdgeInsets.all(5.0),
                      leading: new Icon(Icons.call, size: 38.0),
                      trailing: Icon(Icons.dialpad),
                      title: Text("${snapshot.data[index].data["emergency_service"]}",
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${snapshot.data[index].data["contact_no"]}"),
                      //onTap: () => navigateToBusDetail(snapshot.data[index]),
                      onTap: () async {
                        if (await canLaunch("tel:${snapshot.data[index].data["contact_no"]}")) {
                         await launch("tel:${snapshot.data[index].data["contact_no"]}");
                        }else {
                          throw "Cannot place phone call";
                          }
                      },
                    );
                  }
              );
            }
          }
      ),
    );
  }
}

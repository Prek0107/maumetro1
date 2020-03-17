import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maumetro/maproute.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'buyticket.dart';
import 'guidelines.dart';
import 'stations.dart';
import 'feederbuses.dart';
import 'mecards.dart';
import 'emergencycontacts.dart';
import 'makecomplaint.dart';
import 'help.dart';
import 'root.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  //accountName: Text("${user?.displayName}"),
                  accountEmail: Text("${user?.email}")),
              new ListTile(
                title: new Text("Buy ticket"),
                leading: new Icon(
                    Icons.shopping_cart,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => BuyTickets()));
                },
              ),
              new ListTile(
                title: new Text("Route"),
                leading: new Icon(
                    Icons.map,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MapRoute()));
                },
              ),
              new ListTile(
                title: new Text("Guidelines for using Metro"),
                leading: new Icon(Icons.receipt,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Guidelines()));
                },
              ),
              new ListTile(
                title: new Text("Station"),
                leading: new Icon(Icons.directions_subway,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Station()));
                },
              ),
              new ListTile(
                title: new Text("Feeder bus"),
                leading: new Icon(Icons.directions_bus,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => FeederBus()));
                },
              ),
              new ListTile(
                title: new Text("MECard"),
                leading: new Icon(Icons.credit_card,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MeCard()));
                },
              ),
              new ListTile(
                title: new Text("Emergency Contacts"),
                leading: new Icon(Icons.contact_phone,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => EmergencyContacts()));
                },
              ),
              new ListTile(
                title: new Text("Make complaint"),
                leading: new Icon(Icons.create,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MakeComplaint()));
                },
              ),
              new ListTile(
                title: new Text("Help"),
                leading: new Icon(Icons.help,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Help()));
                },
              ),
              new ListTile(
                title: new Text("Logout"),
                leading: new Icon(Icons.exit_to_app,
                    color: Colors.blueGrey,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  return Alert(
                      context: context,
                      title: "Log out?",
                      desc: "Are you sure you want to log out?",
                      buttons: [
                        DialogButton(
                          child: Text ("Yes"),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value){
                              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
                            }).catchError((e) {
                              print(e);
                            });
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
            ]
        )
    );
  }
}


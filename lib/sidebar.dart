import 'package:flutter/material.dart';
import 'package:maumetro/maproute.dart';
import 'buyticket.dart';
import 'guidelines.dart';
import 'stations.dart';
import 'feederbuses.dart';
import 'mecards.dart';
import 'emergencycontacts.dart';
import 'makecomplaint.dart';
import 'help.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("Buy ticket"),
                leading: new Icon(
                    Icons.shopping_cart,
                    color: Colors.redAccent,
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
                    color: Colors.blue,
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
                    color: Colors.orange,
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
                    color: Colors.teal,
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
                    color: Colors.blueAccent,
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
                    color: Colors.purpleAccent,
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
                    color: Colors.redAccent,
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
                    color: Colors.orange,
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
                    color: Colors.teal,
                    size: 35.0
                ),
                trailing: Icon (Icons.keyboard_arrow_right),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Help()));
                },
              ),
            ]
        )
    );
  }
}

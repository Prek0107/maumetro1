//This is the buy ticket page whereby the user can buy his ticket by selecting values from the dropdown
//The values from the dropdown has been retrieved from the database
//The price and distance has also been retrieved from the database as this mobile application provides real data
//Thus, price was not calculated as these are fixed according to some rules and performing calculations would falsify the actual data
//Every data used has been taken from the official metro express website
//However, the estimated time has been calculated from the data on the official website (26 km track takes 41 minutes)
//Data has been validated for the buying of tickets

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maumetro/stations.dart';
import 'package:maumetro/ticketModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'sidebar.dart';

class BuyTickets extends StatefulWidget {
  @override
  _BuyTicketsState createState() => _BuyTicketsState();
}

var selectedTicketType, selectedTicketOrigin, selectedTicketDestination, document, time;
String price, distance;

Widget _circularProgressIndicator() {
  return CircularProgressIndicator(); //loading
}

class _BuyTicketsState extends State<BuyTickets> {

  @override
  void initState() {
    calculatePrice();
    totalPrice();
    calculateDistance();
    totalDistance();
    calculateTime();
    totalTime();
    super.initState();
  }

//Finding the price according to the selection of type of ticket, origin and destination
  Future<void> calculatePrice() async {
    document = await Firestore.instance.collection('ticket_price').document(selectedTicketType).collection('$selectedTicketOrigin - $selectedTicketDestination').document('$selectedTicketOrigin - $selectedTicketDestination').get();
    if (document.data != null) {
      setState(() {
        price = document.data['price'];
      });
    }
  }

//Finding the distance according to the selection of origin and destination
  Future<void> calculateDistance() async {
    document = await Firestore.instance.collection('ticket_price').document(selectedTicketType).collection('$selectedTicketOrigin - $selectedTicketDestination').document('$selectedTicketOrigin - $selectedTicketDestination').get();
    if (document.data != null) {
      setState(() {
        distance = document.data['distance'];
      });
    }
  }

  //retrieves data distance from database and calculates time according to distance (has been explained in the report)
  //26 km in covered in 41 minutes - official data from metroExpress
  //1 km takes approximately 1.5 minutes (41/26)
  //thus, time is calculated by multiplying by 1.5 (double)
  //converts the calculated value to 2 significant figures to be displayed
  Future<void> calculateTime() async {
    document = await Firestore.instance.collection('ticket_price').document(selectedTicketType).collection('$selectedTicketOrigin - $selectedTicketDestination').document('$selectedTicketOrigin - $selectedTicketDestination').get();
    if (document.data != null) {
      setState(() {
        distance = document.data['distance'];
        time= (double.parse(distance) * 1.5).toStringAsFixed(0);
      });
    }
  }

//Checking the value of price
  String totalPrice() {
    calculatePrice();
    if (price == null) {
      return "0";
    }
    else {
      return price;
    }
  }

//Checking the value of distance
  String totalDistance() {
    calculateDistance();
    if (distance == null) {
      return "0";
    }
    else {
      return distance;
    }
  }

//Checking the value of time
  String totalTime() {
    calculateTime();
    if (time == null) {
      return "0";
    }
    else {
      return time;
    }
  }

//saves ticket to database
  Future<void> postTickets(final tickets) async{
    Firestore firestore = Firestore.instance;
    firestore.collection("ticket_bought").add(tickets)
        .then((DocumentReference document) {
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }

//map the values and then save ticket bought to database
  void saveToDatabase() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String type1 = selectedTicketType;
    final String origin1 = selectedTicketOrigin;
    final String destination1 = selectedTicketDestination;
    final String userid = user.uid;
    final String price1 = totalPrice();
    final DateTime date1 = DateTime.now();

    final TicketModel tickets = TicketModel(type: type1, origin: origin1, destination: destination1, uid: userid, price: price1, date: date1);
    postTickets(tickets.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Buy tickets"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20.0),

//data being retrieved from database for the ticket type dropdown
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("ticket_price").snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: _circularProgressIndicator(),
                  );
                }
                else{
                  List<DropdownMenuItem> ticketType=[];
                  for(int i=0; i<snapshot.data.documents.length; i++){
                    DocumentSnapshot snap=snapshot.data.documents[i];
                    ticketType.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        value: "${snap.documentID}",
                      )
                    );
                  }
//Dropdown values being displayed together with the snack bar which appears on the bottom of the screen when a value has been selected
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                        SizedBox(width: 20.0),
                        DropdownButton(
                          items: ticketType,
                          onChanged: (ticketTypeValue){
                            final snackBar=SnackBar(
                              content:
                              Text('Selected ticket type is $ticketTypeValue',
                                style: TextStyle(color: Colors.redAccent),),
                                duration: Duration(milliseconds: 500)
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              selectedTicketType= ticketTypeValue;
                            });
                          },
                          value: selectedTicketType,
                          isExpanded: false,
                          hint: new Text(
                            "Choose ticket type",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      SizedBox(height: 80.0),
                    ],

                  );
                }
              },
            ),
//data being retrieved from database for the ticket origin dropdown
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("ticket_origin").snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: _circularProgressIndicator(),
                  );
                }
                else{
                  List<DropdownMenuItem> ticketOrigin=[];
                  for(int i=0; i<snapshot.data.documents.length; i++){
                    DocumentSnapshot snap=snapshot.data.documents[i];
                    ticketOrigin.add(
                        DropdownMenuItem(
                          child: Text(
                            snap.documentID,
                            style: TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          value: "${snap.documentID}",
                        )
                    );
                  }

//Dropdown values being displayed together with the snack bar which appears on the bottom of the screen when a value has been selected
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                      SizedBox(width: 20.0),
                      DropdownButton(
                        items: ticketOrigin,
                        onChanged: (ticketOriginValue){
                          final snackBar=SnackBar(
                            content:
                            Text('Selected ticket origin is $ticketOriginValue',
                              style: TextStyle(color: Colors.redAccent),),
                              duration: Duration(milliseconds: 500)
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedTicketOrigin= ticketOriginValue;
                          });
                        },
                        value: selectedTicketOrigin,
                        isExpanded: false,
                        hint: new Text(
                          "Choose origin",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 80.0),
                    ],

                  );
                }
              },
            ),

//data being retrieved from database for the ticket destination dropdown
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("ticket_destination").snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: _circularProgressIndicator(),
                  );
                }
                else{
                  List<DropdownMenuItem> ticketDestination=[];
                  for(int i=0; i<snapshot.data.documents.length; i++){
                    DocumentSnapshot snap=snapshot.data.documents[i];
                    ticketDestination.add(
                        DropdownMenuItem(
                          child: Text(
                            snap.documentID,
                            style: TextStyle(color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          value: "${snap.documentID}",
                        )
                    );
                  }

//Dropdown values being displayed together with the snack bar which appears on the bottom of the screen when a value has been selected
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                      SizedBox(width: 20.0),
                      DropdownButton(
                        items: ticketDestination,
                        onChanged: (ticketDestinationValue){
                          final snackBar=SnackBar(
                            content:
                            Text('Selected ticket destination is $ticketDestinationValue',
                              style: TextStyle(color: Colors.redAccent),),
                              duration: Duration(milliseconds: 500)
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedTicketDestination= ticketDestinationValue;
                          });
                        },
                        value: selectedTicketDestination,
                        isExpanded: false,
                        hint: new Text(
                          "Choose ticket destination",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 80.0),
                    ],

                  );
                }
              },
            ),

            SizedBox(height: 60.0),

//Displays the price, distance and estimated travel time according to selected dropdown
            Text("Price = Rs " + totalPrice(), style: TextStyle(color: Colors.redAccent, fontSize: 20.0, fontWeight: FontWeight.bold,)),
            Text("Distance = " + totalDistance() + " km", style: TextStyle(color: Colors.redAccent, fontSize: 20.0, fontWeight: FontWeight.bold,)),
            Text("Estimated time = " + totalTime() + " minutes", style: TextStyle(color: Colors.redAccent, fontSize: 20.0, fontWeight: FontWeight.bold,)),

            SizedBox(height: 60.0),

//buy ticket button
            OutlineButton(
              child: Text('Buy ticket', style: TextStyle(fontSize: 25.0)),
              padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 59.0), //size of button
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              borderSide: BorderSide(color: Colors.black12, width: 3),
              onPressed: (){
//dialog box is displayed if any value has not been selected - each dropdown value should be selected to be able to buy the ticket
                if(selectedTicketType == null || selectedTicketOrigin == null || selectedTicketDestination == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Please choose an option from all of the dropdown"),
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

//Alert displayed if the same value has been selected for both the origin and destination
                }else
                  if(selectedTicketOrigin == selectedTicketDestination) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Origin and destination cannot be the same, please choose again."),
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
                  } else{

//Dialog box is displayed to allow the user to confirm if he is sure that he wants to buy the ticket
//On selecting yes, the transaction is complete and the user can view his ticket bought history in the 'ticket bought' section
//On selecting no, the transsaction is cancelled and the user is allowed to make other selections
                  return Alert(
                      context: context,
                      title: "Buy ticket?",
                      desc: "Are you sure you want to buy the ticket?",
                      buttons: [
                        DialogButton(
                          child: Text ("Yes"),
                          onPressed: () {
                            saveToDatabase(); //ticket is saved to database
                            Navigator.pop(context); //pops alert dialog box
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Ticket bought. You can view your tickets in the tickets bought section"),
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
                                    title: Text("Ticket not bought"),
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
                return null;
              },
            ),

            SizedBox(height: 60.0,),

            OutlineButton(
                child: Text('View tickets bought', style: TextStyle(fontSize: 15.0)),
                padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 59.0), //size of button
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                borderSide: BorderSide(color: Colors.black12, width: 3),
                onPressed: (){
                  return Alert(
                      context: context,
                      title: "View tickets bought?",
                      desc: "Are you sure you want view the tickets bought?",
                      buttons: [
                        DialogButton(
                          child: Text ("Yes"),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value){
                              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Station()));
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
                }
            ),
          ],
        )
      ),
    );
  }

}

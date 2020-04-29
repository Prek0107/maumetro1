import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class BuyTickets extends StatefulWidget {
  @override
  _BuyTicketsState createState() => _BuyTicketsState();
}

var selectedTicketType, selectedTicketOrigin, selectedTicketDestination, document;
String price;

Widget _circularProgressIndicator() {
  return CircularProgressIndicator(); //loading
}

class _BuyTicketsState extends State<BuyTickets> {

  @override
  void initState() {



    calculatePrice();
    totalPrice();
    super.initState();
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
                          style: TextStyle(color: Colors.teal),
                        ),
                        value: "${snap.documentID}",
                      )
                    );
                  }
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                        SizedBox(width: 50.0),
                        DropdownButton(
                          items: ticketType,
                          onChanged: (ticketTypeValue){
                            final snackBar=SnackBar(
                              content:
                              Text('Selected ticket type is $ticketTypeValue', style: TextStyle(color: Colors.blueGrey),),
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
                      SizedBox(height: 20.0),
                    ],

                  );
                }
              },
            ),
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
                            style: TextStyle(color: Colors.teal),
                          ),
                          value: "${snap.documentID}",
                        )
                    );
                  }
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                      SizedBox(width: 50.0),
                      DropdownButton(
                        items: ticketOrigin,
                        onChanged: (ticketOriginValue){
                          final snackBar=SnackBar(
                            content:
                            Text('Selected ticket origin is $ticketOriginValue', style: TextStyle(color: Colors.blueGrey),),
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
                      SizedBox(height: 20.0),
                    ],

                  );
                }
              },
            ),
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
                            style: TextStyle(color: Colors.teal),
                          ),
                          value: "${snap.documentID}",
                        )
                    );
                  }
                  return Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Icon(Icons.person, size: 25.0, color: Colors.blueGrey),
                      SizedBox(width: 50.0),
                      DropdownButton(
                        items: ticketDestination,
                        onChanged: (ticketDestinationValue){
                          final snackBar=SnackBar(
                            content:
                            Text('Selected ticket destination is $ticketDestinationValue', style: TextStyle(color: Colors.blueGrey),),
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
                      SizedBox(height: 20.0),
                    ],

                  );
                }
              },
            ),


          Text(totalPrice()),


// ticketTypeValue // ticketOriginValue   //ticketDestinationValue
//          StreamBuilder<QuerySnapshot>(
//            stream: Firestore.instance.collection('ticket_price').snapshots(),
//            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//              if (!snapshot.hasData) return new Text('Loading...');
//              return new ListView(
//                children: snapshot.data.documents.map((DocumentSnapshot document) {
//                  return new ListTile(
//                    title: new Text(document["ticketTypeValue"]),
//                    //subtitle: new Text(document['author']),
//                  );
//                }).toList(),
//              );
//            },
//          ),





            OutlineButton(
              onPressed: (){

              },
              child: Text('Buy ticket', style: TextStyle(
                  fontSize: 20.0)),
              padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 59.0), //size of button
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              borderSide: BorderSide(color: Colors.black12, width: 3),
            ),
          ],
        )
      ),
    );
  }
  Future<void> calculatePrice() async {
    document = await Firestore.instance.collection('ticket_price').document(selectedTicketType).collection('$selectedTicketOrigin - $selectedTicketDestination').document('$selectedTicketOrigin - $selectedTicketDestination').get();
    if (document.data != null) {
      setState(() {
        price = document.data['price'];
      });

    }
  }

  String totalPrice() {
    calculatePrice();
    if (price == null) {
      return "0";
    }
    else {
      return price;
    }
  }
}

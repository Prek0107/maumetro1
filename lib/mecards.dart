import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class MeCard extends StatefulWidget {
  @override
  _MeCardState createState() => _MeCardState();
}

class _MeCardState extends State<MeCard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("MECard"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
        body: CardList(),
      ),
    );
  }
}

//Displays the list of the feeder bus
class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {

  Future getCard() async {
    //instantiate cloud firestore
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("mecard").orderBy("type").getDocuments();
    return qs.documents;
  }

  navigateToCardDetail(DocumentSnapshot card){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetails(card: card,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getCard(),
          builder: (_, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: _circularProgressIndicator()
              );
            } else {

              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  separatorBuilder: (_, index) => Divider(),
                  itemBuilder: (_, index) {

                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.transparent,
                        child: ClipRect(
                          child: Image.network(snapshot.data[index].data["image"]),
                        ),
                      ),

                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text("${snapshot.data[index].data["type"]}",
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () => navigateToCardDetail(snapshot.data[index]) ,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    );
                  });

            }
          }),
    );
  }
}

Widget _circularProgressIndicator() {
  return CircularProgressIndicator(); //loading
}

//Displays the details of the feeder bus
class CardDetails extends StatefulWidget {

  final DocumentSnapshot card;
  CardDetails({this.card});

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text (widget.card.data["type"]),
          centerTitle: true
      ),
      body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Column(
            children: <Widget>[
              Image.network(
                "${widget.card.data["image"]}",
                //width: 250,
                //height: 150,
                alignment: Alignment.topCenter,
              ),
              SizedBox(height: 20,),
              Text("MECard type",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold
                ),
              ),
              Text("${widget.card.data["type"]}",
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.5
                ),
              ),
              SizedBox(height: 20,),
              Text("Description",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold
                ),
              ),
              Text("${widget.card.data["description"]}",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text("Availability",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold
                ),
              ),
              Text("${widget.card.data["availability"]}",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text("Price",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold
                ),
              ),
              Text("${widget.card.data["price"]}",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5
                ),
              ),
              SizedBox(height: 20,),
              Text("Travel document needed",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold
                ),
              ),
              Text("${widget.card.data["travel_documents"]}",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.5
                ),
              ),
//              Text (
//              "MECard type: " + "${widget.card.data["type"]}" + "\n\n" +
//              "Description: " + "${widget.card.data["description"]}" + "\n\n" +
//              "Availability: " + "${widget.card.data["availability"]}" + "\n\n" +
//              "Price: " + "${widget.card.data["price"]}" + "\n\n" +
//              "Travel document needed: " + "${widget.card.data["travel_documents"]}" + "\n\n"
//            )
            ],
        ),
      ),
      );
  }
}



//class MeCard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("MECard"),
//            centerTitle: true
//        ),
//        //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}
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
//                      leading: CircleAvatar(
//                        backgroundImage: NetworkImage(snapshot.data[index].data["image"]),
//                      ),

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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListTile(
              title: Text (
                "MECard type: " + "\n" + "${widget.card.data["type"]}" + "\n\n" +
                "Description: " + "\n" + "${widget.card.data["description"]}" + "\n\n" +
                "Availability: " + "\n" + "${widget.card.data["availability"]}" + "\n\n" +
                "Price: " + "\n" + "${widget.card.data["price"]}" + "\n\n" +
                "Travel document needed: " + "\n" + "${widget.card.data["travel_documents"]}" + "\n\n"
             ),
            //subtitle: Text("Description: " + "${widget.card.data["description"]}"),
              // image: NetworkImage("${user.photoUrl}"),
            ),
          ),
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
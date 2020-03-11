import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class FeederBus extends StatefulWidget {
  @override
  _FeederBusState createState() => _FeederBusState();
}

class _FeederBusState extends State<FeederBus> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Feeder bus"),
            centerTitle: true
        ),
        drawer: new Sidebar(),
        body: BusList(),//calling the sidebar
      ),
    );
  }
}

//Displays the list of the feeder bus
class BusList extends StatefulWidget {
  @override
  _BusListState createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  Future getBus() async {
    //instantiate cloud firestore
    var firestore = Firestore.instance;
    QuerySnapshot q = await firestore.collection("feeder_bus").orderBy("route_no").getDocuments();
    return q.documents;
  }

  navigateToBusDetail(DocumentSnapshot bus){
    Navigator.push(context, MaterialPageRoute(builder: (context) => BusDetails(bus: bus,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getBus(),
        builder: (_, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading..."),
          );
        } else {

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {

                return ListTile(
                  title: Text("${snapshot.data[index].data["route_no"]}"),
                  onTap: () => navigateToBusDetail(snapshot.data[index]),
                );
          });
        }
      }),
    );
  }
}

//Displays the details of the feeder bus
class BusDetails extends StatefulWidget {

  final DocumentSnapshot bus;
  BusDetails({this.bus});

  @override
  _BusDetailsState createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text (widget.bus.data["route_no"]),
            centerTitle: true
        ),
        body: Container(
          child: Card(
            child: ListTile(
              title: Text (widget.bus.data["route_no"]),
              subtitle: Text(widget.bus.data["station"]),
            ),
          ),
        ),
    );
  }
}


//class FeederBus extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Feeder bus"),
//            centerTitle: true
//        ),
//        drawer: new Sidebar(), //calling the sidebar
//      ),
//    );
//  }
//}

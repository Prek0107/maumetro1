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
        drawer: new Sidebar(), //calling the sidebar
        body: BusList(),
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
                      leading: new Icon(Icons.directions_bus, size: 38.0),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text("${snapshot.data[index].data["route_no"]}",
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${snapshot.data[index].data["station"]}"),
                      onTap: () => navigateToBusDetail(snapshot.data[index]),
                      contentPadding: const EdgeInsets.all(5.0),
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
            title: Text (
                "Route number: " + "\n" + "${widget.bus.data["route_no"]}" + "\n\n" +
                    "Station: " + "\n" + "${widget.bus.data["station"]}" + "\n"),
            subtitle: Text("Bus route: " + "\n" + "${widget.bus.data["bus_route"]}"),
            contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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

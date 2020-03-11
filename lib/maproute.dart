import 'dart:async';
import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapRoute extends StatefulWidget {
  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  List<Marker> allMarkers = [];
  //String inputaddr='';

  Widget loadMap() {
    return StreamBuilder(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Text('Loading maps...');
        for(int i=0; i<snapshot.data.documents.length; i++) {
          allMarkers.add(new Marker(
            width: 45.0,
            height: 45.0,
            point: new LatLng(
              snapshot.data.documents[i]['coordinates'].latitude,
                snapshot.data.documents[i]['coordinates'].longitude),
            builder: (context) => new Container(
              child: IconButton(
                icon: Icon(Icons.directions_subway),
                color: Colors.black38,
                iconSize: 40.0,
                  onPressed: () {
                  print(snapshot.data.documents[i]['station']);
                  },
              ),
            )
          ));
        }

        return new FlutterMap(
            options: new MapOptions(
                center: new LatLng(-20.21, 57.48), minZoom: 10.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: allMarkers)
            ]
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Route Map"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
        body: loadMap()
      ),
    );
  }
}



//class MapRoute extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () {
//        return new Future(() => false);
//      },
//      child: Scaffold(
//        appBar: new AppBar(
//            title: new Text("Route Map"),
//            centerTitle: true
//        ),
//        //calling the sidebar
//        drawer: new Sidebar(),
//      ),
//    );
//  }
//}

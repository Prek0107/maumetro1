//This is the page where the information about the guidelines are retrieved and displayed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class Guidelines extends StatefulWidget {
  @override
  _GuidelinesState createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Guidelines for using Metro"),
            centerTitle: true
        ),
        //calling the sidebar
        drawer: new Sidebar(),
        body: GuidelinesList()
      ),
    );
  }
}

class GuidelinesList extends StatefulWidget {
  @override
  _GuidelinesListState createState() => _GuidelinesListState();
}

class _GuidelinesListState extends State<GuidelinesList> {

  Future getGuidelines() async {
    //instantiate cloud firestore
    var firestore = Firestore.instance;
    QuerySnapshot q = await firestore.collection("guidelines").orderBy("title").getDocuments();
    return q.documents;
  }

  navigateToGuidelinesDetail(DocumentSnapshot guidelines){
    Navigator.push(context, MaterialPageRoute(builder: (context) => GuidelinesDetails(guidelines: guidelines,)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getGuidelines(),
          builder: (_, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: _circularProgressIndicator(),
              );
            } else {

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {

                    return Card(
                      child: ListTile(
                        leading: new Icon(Icons.receipt, size: 38.0, color: Colors.red),
                        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.red),
                        title: Text("${snapshot.data[index].data["title"]}",
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () => navigateToGuidelinesDetail(snapshot.data[index]),
                        contentPadding: const EdgeInsets.all(5.0),
                      )
                    );
                  }
              );
            }
          }),
    );
  }
}


Widget _circularProgressIndicator() {
  return CircularProgressIndicator(); //loading
}

class GuidelinesDetails extends StatefulWidget {

  final DocumentSnapshot guidelines;
  GuidelinesDetails({this.guidelines});

  @override
  _GuidelinesDetailsState createState() => _GuidelinesDetailsState();
}

class _GuidelinesDetailsState extends State<GuidelinesDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text (widget.guidelines.data["title"]),
          centerTitle: true
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: <Widget>[
            Text("${widget.guidelines.data["title"]}",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text("${widget.guidelines.data["info"]}",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Open Sans',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],

        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel{
  final String complaint;
  final String uid;
  final Timestamp date;

  ComplaintModel({
    this.complaint,
    this.uid,
    this.date
  });

  Map<String, dynamic> toMap(){
    return {
      "complaint" : this.complaint,
      "UID" : this.uid,
      "date" : this.date
    };
  }
}
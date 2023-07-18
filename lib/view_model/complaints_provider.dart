import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Complaint {
  String? complaintId;
  String? status;
  String? name;
  String? roll;
  String? subject;
  String? desciption;
  String? sport;
  String? day;

  Complaint(
      {required this.roll,
      required this.day,
      required this.complaintId,
      required this.status,
      required this.subject,
      required this.desciption,
      required this.name,
      required this.sport});

  Complaint.fromJson(Map<String, dynamic> json) {
    complaintId=json['complaintId'];
    status=json['status'];
    name = json['name'];
    roll = json['roll number'];
    subject = json['subject'];
    desciption = json['complaint'];
    sport = json['sports'];
    day=json['day'];
  }
}

class ComplaintProvider with ChangeNotifier {
  Stream<List<Complaint>>? getComplaints() {
    final complaints = FirebaseFirestore.instance.collection('complaints').orderBy('time');
    var data = complaints.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Complaint.fromJson(doc.data())).toList().reversed.toList());
    return data;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Announcement{
  String? posterUrl;
  String? eventName;
  String? date;
  String? note;
  Announcement({required this.eventName,required this.date,required this.note,required this.posterUrl});

  Announcement.fromMap(Map<String, dynamic> json){
    posterUrl=json['image'];
    eventName=json['Event Name'];
    note=json['Note'];
    date=json['Date'];


  }
}

class AnnouncementProvider with ChangeNotifier{
  Stream<List<Announcement>> announcementData(){
    final snapshots=FirebaseFirestore.instance.collection('announcements').snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((doc) => Announcement.fromMap(doc.data())).toList());
  }
}
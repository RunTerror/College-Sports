import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AchivementProvider with ChangeNotifier {
  List<dynamic> list = [];
  Stream<List<Map<String, dynamic>>> getAchievement(String sports) {
    final snapshots = FirebaseFirestore.instance
        .collection("Sports Achievements")
        .doc(sports)
        .collection('achievements')
        .snapshots();
    final data= snapshots.map((snapshot) => snapshot.docs.map((doc) {
          return {
            "description": doc.data()['description'],
            "event name": doc.data()['event name'],
            "imageUrl": doc.data()['image'],
            "position": doc.data()['position'],
            "team": doc.data()['team'],
            "year": doc.data()['year'],
          };
        }).toList());
        print(data);
        return data;
  }
}

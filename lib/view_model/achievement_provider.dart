import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AchievementModel {
  String? imageUrl;
  String? year;
  String? description;
  String? eventName;
  String? position;
  String? teamMembers;

  AchievementModel(
      {required this.description,
      required this.eventName,
      required this.imageUrl,
      required this.position,
      required this.teamMembers,
      this.year});

  AchievementModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image'];
    description = json['Description'];
    eventName = json['Event Name'];
    teamMembers = json['Team Members'];
    position = json['position'];
    year = json['Year'];
  }
}

class AchivementProvider with ChangeNotifier {
  Stream<List<AchievementModel>> getAchievement(String sports) {
    final snapshots = FirebaseFirestore.instance.collection(sports).snapshots();
    final sportAchievement = snapshots.map((snapshot) => snapshot.docs
        .map((doc) => AchievementModel.fromJson(doc.data()))
        .toList());
    return sportAchievement;
  }
}

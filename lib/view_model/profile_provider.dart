import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  String? name;
  String? email;

  Profile({required this.email, required this.name});
  Profile.fromMap(Map<String, dynamic> m) {
    name = m['name'];
    email = m['email'];
  }
}

class FullUserProfile {
  String? position;
  String? profile;
  String? name;
  String? email;
  String? branch;
  String? sport;
  String? batch;
  FullUserProfile(
      {required this.profile,
      required this.position,
      required this.batch,
      required this.branch,
      required this.email,
      required this.name,
      required this.sport});

  FullUserProfile.fromMap(Map<String, dynamic> json) {
    position=json['position'];
    profile = json['profile'];
    name = json['name'];
    email = json['email'];
    branch = json['branch'];
    batch = json['batch'];
    sport = json['sports'];
  }
}

class ProfileProvider with ChangeNotifier {
  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('name') == null ||
        prefs.getString('email') == "Abhishek Kumar") {
      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      prefs.setString('name', doc.data()!['name']);
      prefs.setString('email', doc.data()!['email']);
      String name = prefs.getString('name') ?? '';
      String email = prefs.getString('email') ?? '';
      return {'name': name, 'email': email};
    } else {
      String name = prefs.getString('name') ?? '';
      String email = prefs.getString('email') ?? '';
      return {'name': name, 'email': email};
    }
  }

  Stream<FullUserProfile> getUserProfile() {
    final snapshots = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return snapshots
        .map((snapshot) => FullUserProfile.fromMap(snapshot.data()!));
  }

  Future<String> getPosition()async{
    final doc=await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return doc.data()!['position'];
  }
}

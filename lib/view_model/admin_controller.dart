import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AdminProfile {
  String? name;
  String? email;
  String? profile;
  String? department;
  String? position;

  AdminProfile(
      {required this.email,
      required this.name,
      required this.profile,
      required this.department,
      required this.position});

  AdminProfile.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profile = json['profile'];
    department = json['department'];
    position = json['position'];
  }
}

class AdminProfileController with ChangeNotifier {
  Stream<AdminProfile> getAdminProfile() {
    final snapshots = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return snapshots.map((snapshot) {
      return AdminProfile.fromMap(snapshot.data()!);
    });
  }
}

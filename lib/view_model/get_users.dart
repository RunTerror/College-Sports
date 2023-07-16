import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? position;
  String? email;
  String? name;

  UserModel({this.email, this.position, required this.name});

  UserModel.fromMap(Map<String, dynamic> json) {
    position = json['position'];
    email = json['email'];
    name = json['name'];
  }
}

class GetUsers with ChangeNotifier {
  Stream<List<UserModel>> getUsers() {
    final snapshots =
        FirebaseFirestore.instance.collection('Users').snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((doc) {
          return UserModel.fromMap(doc.data());
        }).toList());
  }
}

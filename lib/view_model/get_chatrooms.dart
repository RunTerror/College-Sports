import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomsProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;

  Stream<List<Map<String, dynamic>>> getChatrooms() {
    final snapshots = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth!.uid)
        .collection('groups')
        .snapshots();
    final doc= snapshots.map((snapshot) => snapshot.docs.map((doc) {
          return {"name": doc.data()['name'], "id": doc.data()['id']};
        }).toList());
        return doc;
  }
}

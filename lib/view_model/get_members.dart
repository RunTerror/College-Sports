import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class GetMembersProvider with ChangeNotifier {
   List<Map<String, dynamic>> _selectedList = [];
  List<Map<String, dynamic>> get selectedList => _selectedList;
  var uuid = const Uuid();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  

  createServer(List<Map<String, dynamic>> selectedList, String groupName,
      String name) async {
        print(selectedList);

    String groupId = uuid.v4();

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .set({"members": selectedList, "id": groupId});

    for (int i = 0; i < selectedList.length; i++) {
      String uid = selectedList[i]['uid'];

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('groups')
          .doc(groupId)
          .set({
        "name": groupName,
        "id": groupId,
      });
    }

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('chats')
        .add({
      "time": FieldValue.serverTimestamp(),
      "message": "$name Created This Group.",
      "type": "notify",
    });
    _isLoading = false;
    notifyListeners();
  }

  checkIfExtst(Map<String, dynamic> memberDetails) {
    bool check = false;
    for (int i = 0; i < _selectedList.length; i++) {
      if (_selectedList[i]['email'] == memberDetails['email']) {
        check = true;
        break;
      }
    }
    if (check == false) {
      addMember(memberDetails);
    }
    notifyListeners();
  }

  addMember(Map<String, dynamic> memberDetails) {
   
      _selectedList.add({
        "name": memberDetails['name'],
        "email": memberDetails['email'],
        "uid": memberDetails['uid'],
        "isAdmin": memberDetails['email']==FirebaseAuth.instance.currentUser!.email? true: false
      });

    notifyListeners();
  }

  removerMember(Map<String, dynamic> memberDetails) {
    for (var i = 0; i < _selectedList.length; i++) {
      if (_selectedList[i]['email'] == memberDetails['email']) {
        _selectedList.removeAt(i);
      }
    }
    notifyListeners();
  }

  removeAllMembers(){
   _selectedList=[];
   notifyListeners();
    
  }

  Stream<List<Map<String, dynamic>>> getMembers() {
    final snapshots =
        FirebaseFirestore.instance.collection('Users').snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((doc) {
          return {
            "name": doc.data()['name'],
            "uid": doc.data()['uid'],
            "email": doc.data()['email'],
            "position": doc.data()['email']
          };
        }).toList());
  }
}

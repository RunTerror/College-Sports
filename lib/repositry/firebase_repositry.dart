import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<bool> isemailverified() async {
    return user.emailVerified;
  }

  sendVerification() async {
    await user.sendEmailVerification();
  }

  Future signUpWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      if (email[0] == '2') {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(_auth.currentUser?.uid)
              .set({
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "position": 'user',
            "email": email,
            "name": name,
          });
        });

        await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

      } else {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(_auth.currentUser?.uid)
              .set({
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "position": 'admin',
            "email": email,
            "name": name,
          });
        });
         await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future loginInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }

  Future<DocumentSnapshot> getSnapshot() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser?.uid)
        .get();
    return snapshot;
  }
}

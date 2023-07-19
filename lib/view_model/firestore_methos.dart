import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreMethods {
  

  getName() async {
    final data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (data.exists) {
      return data.data()!['name'];
    } else {
    }
  }
  
  Future<String> getroll() async {
    final data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
   
      String roll= data.data()!['email'];
      return roll.substring(0, roll.length-17);
  }

  Future<String> getEmail()async{
     final data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
      return data.data()!['email'];
    
  }


}

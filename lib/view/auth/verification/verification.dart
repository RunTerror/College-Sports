import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view/home_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isverified=false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isverified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isverified) {
      sendVerification();
    }

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      checkemailverified();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isverified) timer?.cancel();
  }

  Future sendVerification() async {
    try {
      print("sent");
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Utils.snackBar(e.message!, context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.email);
    var theme=Theme.of(context);
    return isverified? const HomeScreen(): Scaffold(

      appBar: AppBar(title:const Text("Verification screen", style: TextStyle(fontSize: 20),),backgroundColor: theme.colorScheme.secondary,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text("A verification link is sent to your email account"),
          const SizedBox(height: 30,),
          InkWell(onTap: sendVerification,child: Container(
            decoration: BoxDecoration(color: theme.colorScheme.secondary,),
            height: MediaQuery.of(context).size.height/20,
            width: MediaQuery.of(context).size.width/1.3,alignment: Alignment.center,child:const Text("Resent Email"),))
        ],),
      )
    );
  }
}

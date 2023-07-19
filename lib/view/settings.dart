
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ListTile(title:const Text("Log Out"), onTap: () {
           context.read<FirebaseAuthMethods>().signOut(context);
        },)
      ],),
    );
  }
}
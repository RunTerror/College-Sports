import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/utils/utils.dart';

class ActionButton extends StatelessWidget {
  final String compalintId;
  final String status;
  final IconData icon;
  const ActionButton(
      {super.key,
      required this.status,
      required this.icon,
      required this.compalintId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        child: ListTile(
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Are you sure you want to $status? "),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance
                                .collection('complaints')
                                .doc(compalintId)
                                .update({"status": status}).then((value) {
                                  Navigator.pop(context);
                                  Utils.toastMessage(
                                        "Status Updated to $status");


                                }
                                    );
                          } on FirebaseAuthException catch (e) {
                            Utils.toastMessage(e.message!);
                          }
                        },
                        child: const Text("Yes"))
                  ],
                );
              },
            );
          },
          leading: Icon(icon),
          title: Text(
            status,
          ),
        ),
      ),
    );
  }
}

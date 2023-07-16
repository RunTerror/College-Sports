import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../../resources/Components/profile_widget.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  var uuid = const Uuid();

  TextEditingController sportscontroller = TextEditingController();
  TextEditingController subjectconroller = TextEditingController();
  TextEditingController complaintcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h / 13,
              ),
              const Text(
                "Add complaint",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              const Text("your problems do solve here",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: w,
                height: h / 1.45,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border:
                        Border.all(width: 1, color: theme.colorScheme.primary)),
                child: UserProfileWidget(
                    field1: "Sports",
                    field2: "Subject",
                    fiedld3: "Complaint",
                    text1: sportscontroller,
                    text2: subjectconroller,
                    text3: complaintcontroller),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (sportscontroller.text.isEmpty) {
                    Utils.flushbarErrorMessage("please add sport", context);
                  } else if (subjectconroller.text.isEmpty) {
                    Utils.flushbarErrorMessage("Please add subject", context);
                  } else if (complaintcontroller.text.isEmpty) {
                    Utils.flushbarErrorMessage(
                        "complete your complaint field", context);
                  } else {
                    try {
                      final date = DateTime.now();
                      final data = formatDate(date, [d, '-', M, '-', yyyy]);
                      final email = FirebaseAuth.instance.currentUser!.email;
                      String rollnumber =
                          email!.substring(0, email.length - 17);
                      final userDoc = await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      await FirebaseFirestore.instance
                          .collection('complaints')
                          .add({
                        "date": data,
                        "status": "waiting",
                        "name": userDoc.data()!['name'],
                        "batch": userDoc.data()!['batch'],
                        "sports": sportscontroller.text,
                        "subject": subjectconroller.text,
                        "complaint": complaintcontroller.text,
                        "roll number": rollnumber
                      }).then((documentReference) async {
                        String docid = documentReference.id;
                        await FirebaseFirestore.instance
                            .collection('complaints')
                            .doc(docid)
                            .update({"complaintId": docid});
                        Utils.toastMessage(
                            "Your Complaint is added keep playing");
                      });
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    } on FirebaseAuthException catch (e) {
                      Utils.toastMessage(e.message!);
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: w,
                  height: h / 20,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      border: Border.all(
                          width: 1, color: theme.colorScheme.primary),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

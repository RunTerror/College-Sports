import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/utils/utils.dart';

import '../../resources/Components/admin_profile_widget.dart';

class AdminProfileForm extends StatefulWidget {
  const AdminProfileForm({super.key});

  @override
  State<AdminProfileForm> createState() => _AdminProfileForm();
}

class _AdminProfileForm extends State<AdminProfileForm> {
  bool isLoading = false;
  TextEditingController departmentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
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
                "Profile",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
              const Text("Customise your Profile",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: w,
                height: h / 2.5,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border:
                        Border.all(width: 1, color: theme.colorScheme.primary)),
                child: AdminProfileWidget(
                  departmentController: departmentController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (departmentController.text.isEmpty) {
                    Utils.flushbarErrorMessage(
                        "please enter your department", context);
                  } else {
                    setState(() {
                      isLoading = true;
                    });

                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      "department": departmentController.text,
                    }).then((value) {
                      setState(() {
                        isLoading = false;
                      });

                      Navigator.of(context).pop();
                      Utils.toastMessage("Updated");
                    });
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
                  child: isLoading == false
                      ? const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )
                      : const CircularProgressIndicator(color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

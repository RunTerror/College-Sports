import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/resources/Components/profile_widget.dart';
import 'package:sports_application/utils/utils.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController branchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isLoading = false;
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
                height: h / 1.7,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border:
                        Border.all(width: 1, color: theme.colorScheme.primary)),
                child: UserProfileWidget(
                    fiedld3: "Sports",
                    field1: "Branch",
                    field2: "Batch",
                    text1: branchController,
                    text2: sportsController,
                    text3: yearController),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (branchController.text.isEmpty) {
                    Utils.flushbarErrorMessage(
                        "please enter your branch", context);
                  } else if (yearController.text.isEmpty) {
                    Utils.flushbarErrorMessage(
                        "Please enter your batch", context);
                  } else if (sportsController.text.isEmpty) {
                    Utils.flushbarErrorMessage(
                        "Please enter your sports", context);
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(context.read<FirebaseAuthMethods>().user.uid)
                        .update({
                      "branch": branchController.text,
                      "batch": yearController.text,
                      "sports": sportsController.text
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
                      : const CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

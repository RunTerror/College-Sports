import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/view_model/firestore_methos.dart';
import 'package:sports_application/view_model/profile_controller.dart';


// ignore: must_be_immutable
class AdminProfileWidget extends StatefulWidget {
  TextEditingController departmentController;
  AdminProfileWidget(
      {super.key,
      required this.departmentController});

  @override
  State<AdminProfileWidget> createState() => _AdminProfileWidgetState();
}

class _AdminProfileWidgetState extends State<AdminProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final profileInstance = Provider.of<ProfileCrontroller>(context);
    var theme = Theme.of(context);
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(FirebaseAuth.instance.currentUser!.displayName!,
                            style: const TextStyle(fontSize: 18))
                  ],
                )
              ],
            ),
            Consumer(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    profileInstance.showD(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: profileInstance.profile == null
                        ? null
                        : FileImage(profileInstance.profile!),
                    backgroundColor: theme.colorScheme.secondary,
                    child: profileInstance.profile == null
                        ? Icon(
                            Icons.person_add,
                            color: theme.colorScheme.primary,
                          )
                        : null,
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Email",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Row(
                children: [
                  const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(FirebaseAuth.instance.currentUser!.email!,
                          style: const TextStyle(fontSize: 18))
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Department",
            style:  TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          controller: widget.departmentController,
          decoration: const InputDecoration(hintText: "+Write branch"),
        ),
      ],
    );
  }
}

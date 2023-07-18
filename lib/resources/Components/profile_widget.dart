import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/view_model/profile_controller.dart';

class UserProfileWidget extends StatefulWidget {
  final String field1;
  final String field2;
  final String fiedld3;
  final TextEditingController text1;
  final TextEditingController text2;
  final TextEditingController text3;
  const UserProfileWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.fiedld3,
      required this.field1,
      required this.field2});

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  getRollNumber() {
    var email = context.read<FirebaseAuthMethods>().user.email;
    email = email!.substring(0, email.length - 17);
    return email;
  }

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
                    Text(context.read<FirebaseAuthMethods>().user.displayName!,
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
              "Roll no.",
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
                  Text(getRollNumber(), style: const TextStyle(fontSize: 18))
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.field1,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          controller: widget.text1,
          decoration: const InputDecoration(hintText: "Sports"),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.field2,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          controller: widget.text2,
          decoration: const InputDecoration(hintText: "+Write subject"),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.fiedld3,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          maxLines: 4,
          controller: widget.text3,
          decoration: const InputDecoration(hintText: "+Write Details"),
        ),
      ],
    );
  }
}

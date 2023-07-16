
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/view_model/firestore_methos.dart';
import 'package:sports_application/view_model/profile_controller.dart';

// ignore: must_be_immutable
class UserProfileWidget extends StatefulWidget {
  String field1;
  String field2;
  String fiedld3;
  TextEditingController text1;
  TextEditingController text2;
  TextEditingController text3;
   UserProfileWidget({super.key,required this.text1,required this.text2,required this.text3,required this.fiedld3,required this.field1,required this.field2});

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
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
                    FutureBuilder(
                      builder: (context, snapshot) {
                        final docdata = snapshot.data;
                        return Text("$docdata",
                            style: const TextStyle(fontSize: 18));
                      },
                      future: context.read<FireStoreMethods>().getName(),
                    ),
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
                  FutureBuilder(
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return Text('$data',
                          style: const TextStyle(fontSize: 18));
                    },
                    future: context.read<FireStoreMethods>().getroll(),
                  ),
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
          decoration:const InputDecoration(hintText: "+Write branch"),
        ),
        const SizedBox(
          height: 20,
        ),
         Text(widget.field2,
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          controller: widget.text2,
          decoration:const InputDecoration(hintText: "+Write Year"),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(widget.fiedld3,
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
        TextField(
          controller: widget.text3,
          decoration:const InputDecoration(hintText: "+Write Sports"),
        ),
      ],
    );
  }
}

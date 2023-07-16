import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/achievements_picker.dart';
import 'package:uuid/uuid.dart';

class PreViewScreen extends StatefulWidget {
  final String sport;
  final String event;
  final String year;
  final String description;
  final String teamMembers;
  final String position;
  const PreViewScreen(
      {super.key,
      required this.description,
      required this.event,
      required this.teamMembers,
      required this.year,
      required this.sport
      ,required this.position});

  @override
  State<PreViewScreen> createState() => _PreViewScreenState();
}

class _PreViewScreenState extends State<PreViewScreen> {
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final acobj = Provider.of<AchievementPicker>(context);

    // final arguments=ModalRoute.of(context)!.settings as Map<String, RouteSettings>;
    return Scaffold(
        body: SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: h / 3,
          ),
          Container(
            height: h / 3.3,
            width: w / 1.2,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: theme.colorScheme.primary),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: 2 * h / 9.9,
                  // color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: (acobj.img == null)
                            ? const AssetImage('assets/Images/google.jpeg')
                            : FileImage(acobj.img!) as ImageProvider,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Event Name"),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Year"),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: theme.colorScheme.primary,
                ),
                Container(
                  height: h / 13,
                  child: Row(
                    children: [
                      const Text("Description"),
                      IconButton(
                          onPressed: () {
                            try {
                              String uid = uuid.v4();
                              print(uid.toString());
                              FirebaseFirestore.instance
                                  .collection(widget.sport)
                                  .doc(uid.toString())
                                  .set({
                                    "position": widget.position,
                                    "image": "",
                                "Event Name": widget.event,
                                "Year": widget.year,
                                "Team Members": widget.teamMembers,
                                "Description": widget.description
                              });
                              acobj.uploadPickedImg(widget.sport, uid.toString());
                            } on FirebaseException catch (e) {
                              Utils.toastMessage(e.message!);
                            }
                          },
                          icon: const Icon(Icons.send))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

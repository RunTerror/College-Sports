import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/resources/Components/profile_textfield.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/achievements_picker.dart';
import 'package:uuid/uuid.dart';

class AddAchievement extends StatefulWidget {
  final String sport;
  const AddAchievement({super.key, required this.sport});

  @override
  State<AddAchievement> createState() => _AddAchievementState();
}

class _AddAchievementState extends State<AddAchievement> {
  TextEditingController eventController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController teamMembersController = TextEditingController();
  String event = '';
  String description = '';
  String team = '';
  String position = '';
  String? text;
  final uid = const Uuid();

  @override
  void initState() {
    eventController.addListener(() {
      setState(() {
        event = eventController.text;
      });
    });
    descriptionController.addListener(() {
      setState(() {
        description = eventController.text;
      });
    });
    teamController.addListener(() {
      setState(() {
        team = eventController.text;
      });
    });
    positionController.addListener(() {
      setState(() {
        position = positionController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    eventController.dispose();
    descriptionController.dispose();
    teamController.dispose();
    super.dispose();
  }

  String year = "";
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final provider = Provider.of<AchievementPicker>(context, listen: false);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.colorScheme.secondary,
          leading: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: w,
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Consumer<AchievementPicker>(
              builder: (context, provider, child) {
                return InkWell(
                  onTap: () {
                    provider.selectImage(context);
                  },
                  child: Container(
                    height: w / 1.1,
                    width: w / 1.1,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ExternalColors.darkblue, width: 1)),
                    child: provider.img == null
                        ? const Image(
                            image: AssetImage('assets/Images/img.png'))
                        : Image(
                            image: FileImage(provider.img!),
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                namecontroller: eventController,
                hintText: "Event Name",
                iconData: Icons.event),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: ListTile(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1984),
                              lastDate: DateTime.now())
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            date = value;
                            year = DateFormat.yMMMEd().format(date!);
                          });
                        }
                      });
                    },
                    leading: const Icon(Icons.calendar_month_outlined),
                    title:
                        year == "" ? const Text("Choose Year") : Text(year))),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                namecontroller: positionController,
                hintText: "Position",
                iconData: Icons.group),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                namecontroller: teamController,
                hintText: "Name",
                iconData: Icons.person),
            TextButton(
                onPressed: () {
                  if (teamController.text.trim().isNotEmpty) {
                    provider.addMembers(teamController.text.trim());
                    teamController.clear();
                  }
                },
                child: const Text("Add member")),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: h / 5,
              width: w,
              child: ListView.builder(
                itemCount: provider.members.length,
                itemBuilder: (context, index) {
                  return provider.members.isEmpty
                      ? const Text("Please Add Members")
                      : ListTile(
                          onTap: () {
                            provider
                                .removeMember(provider.members[index]);
                            setState(() {});
                          },
                          title: Text(provider.members[index]),
                          trailing: const Icon(Icons.cancel),
                        );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                maxLine: 3,
                namecontroller: descriptionController,
                hintText: "Description",
                iconData: Icons.description),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                if (provider.img == null) {
                  Utils.flushbarErrorMessage("Select winning image", context);
                } else if (eventController.text.isEmpty) {
                  Utils.flushbarErrorMessage(
                      "Please enter event name", context);
                } else if (year.isEmpty) {
                  Utils.flushbarErrorMessage("Please choose year", context);
                } else if (positionController.text.isEmpty) {
                  Utils.flushbarErrorMessage("Please enter position", context);
                } else if (provider.members.isEmpty) {
                  Utils.flushbarErrorMessage(
                      "Please add team members", context);
                } else if (descriptionController.text.isEmpty) {
                  Utils.flushbarErrorMessage("Please add description", context);
                } else {
                  try {
                    String uniqueid = uid.v4();
                    await FirebaseFirestore.instance
                        .collection("Sports Achievements")
                        .doc(widget.sport)
                        .collection('achievements')
                        .doc(uniqueid)
                        .set({
                      "event name": eventController.text.trim(),
                      "year": year,
                      "position": positionController.text.trim(),
                      "team": provider.members,
                      "description": descriptionController.text.trim()
                    }).then((value) => Utils.toastMessage(
                            "Congratulation new Achievement added!"));
                            if(context.mounted){
                              Navigator.pop(context);
                            }
                    provider.uploadPickedImg(widget.sport, uniqueid);
                    provider.removerMembers();
                    provider.removerImage();
                  } on FirebaseAuthException catch (e) {
                    Utils.snackBar(e.message!, context);
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: h / 15,
                width: w,
                decoration: BoxDecoration(
                    color: ExternalColors.lightgreen,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: const Text("Post"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

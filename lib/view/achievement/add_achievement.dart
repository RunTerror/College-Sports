import 'dart:core';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/resources/Components/profile_textfield.dart';
import 'package:sports_application/view/adminprofile/preview_screen.dart';
import 'package:sports_application/view_model/achievements_picker.dart';

class AddAchievemen extends StatefulWidget {
  final String sport;
  const AddAchievemen({super.key, required this.sport});

  @override
  State<AddAchievemen> createState() => _AddAchievemenState();
}

class _AddAchievemenState extends State<AddAchievemen> {
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
  String? teamMembersCount;

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

    final acobj = Provider.of<AchievementPicker>(context);

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.secondary,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return PreViewScreen(
                      description: descriptionController.text.trim(),
                      event: eventController.text.trim(),
                      teamMembers: teamController.text.trim(),
                      year: year,
                      key: widget.key,
                      sport: widget.sport,
                      position: position);
                }));
              },
              icon: const Icon(Icons.preview))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: w,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              InkWell(
                  onTap: () {
                    acobj.showBox(context);
                  },
                  child: Container(
                    height: w / 1.1,
                    width: w / 1.1,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ExternalColors.darkblue, width: 2)),
                    child: acobj.img == null
                        ? null
                        : Image(
                            image: FileImage(acobj.img!),
                            fit: BoxFit.cover,
                          ),
                  )),
              const SizedBox(
                height: 20,
              ),
              ProfileField(
                  namecontroller: eventController,
                  hintText: "Event",
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
                              lastDate: DateTime(DateTime.now().year + 1))
                          .then((value) {
                        setState(() {
                          date = value!;
                          year = formatDate(date!, [d, '-', M, '-', yyyy]);
                        });
                      });
                    },
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: year == "" ? const Text("Choose Year") : Text(year),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text(
                              "Single or Team?",
                              style: TextStyle(fontSize: 20),
                            ),
                            actions: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1)),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        text = 'single';
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    leading: const Icon(Icons.person),
                                    title: const Text("Single"),
                                  ),
                                ),
                              ),
                              TextField(
                                onSubmitted: (value) {
                                  text=value;
                                  Navigator.of(context).pop();

                                },
                                keyboardType: TextInputType.number,
                                  controller: teamMembersController,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.group),
                                      border: OutlineInputBorder(),
                                      hintText: "Team size")),
                            ],
                          );
                        });
                  },
                  leading: const Icon(Icons.person),
                  title: text == null ? const Text("Select") : Text(text!),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileField(
                // maxLine: text=="single"? 1: int.parse(text!),
                  namecontroller: teamController,
                  hintText: "name",
                  iconData: Icons.group),
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
                  maxLine: 3,
                  namecontroller: descriptionController,
                  hintText: "Description",
                  iconData: Icons.description),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

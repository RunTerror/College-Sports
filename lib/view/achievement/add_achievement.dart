import 'dart:core';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/resources/Components/profile_textfield.dart';
import 'package:sports_application/view/adminprofile/preview_screen.dart';
import 'package:sports_application/view_model/achievements_picker.dart';

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

    final provider = Provider.of<AchievementPicker>(context, listen: false);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.secondary,
      ),
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
                    provider.showBox(context);
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
                maxLine: 3,
                namecontroller: descriptionController,
                hintText: "Description",
                iconData: Icons.description),
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
                namecontroller: positionController,
                hintText: "Name",
                iconData: Icons.person),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

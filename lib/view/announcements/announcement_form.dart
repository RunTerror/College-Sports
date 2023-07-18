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

class AnnouncementForm extends StatefulWidget {
  const AnnouncementForm({super.key});

  @override
  State<AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  TextEditingController eventController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String date = "";
  bool isLoading = false;
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel)),
        title: const Text("Add announcement"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: w,
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Consumer<AchievementPicker>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    value.showBox(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(width: 1)),
                    height: h / 2.3,
                    width: w / 1.1,
                    child: value.poster == null
                        ? const Image(
                            image: AssetImage(
                              'assets/Images/another.png',
                            ),
                            fit: BoxFit.cover,
                          )
                        : Image(
                            fit: BoxFit.cover, image: FileImage(value.poster!)),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                namecontroller: eventController,
                hintText: "Event name",
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
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 10))
                        .then((value) {
                      setState(() {
                        date = DateFormat('d-MMM-yyyy').format(value!);
                      });
                    });
                  },
                  leading: const Icon(Icons.calendar_month),
                  title: date == "" ? const Text("Choose Date") : Text(date),
                )),
            const SizedBox(
              height: 20,
            ),
            ProfileField(
                namecontroller: noteController,
                hintText: "Add Note",
                iconData: Icons.note),
            const SizedBox(
              height: 20,
            ),
            Consumer<AchievementPicker>(
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    if (eventController.text.isEmpty) {
                      Utils.flushbarErrorMessage(
                          "Please add event name", context);
                    } else if (date == "") {
                      Utils.flushbarErrorMessage("Please select date", context);
                    } else if (noteController.text.isEmpty) {
                      Utils.flushbarErrorMessage("Please add note ", context);
                    } else {
                      try {
                        isLoading = true;
                        final uid = uuid.v4();
                        value.uploadPickedPoster(uid);
                        FirebaseFirestore.instance
                            .collection('announcements')
                            .doc(uid)
                            .set({
                          "time": FieldValue.serverTimestamp(),
                          "Event Name": eventController.text,
                          "Date": date,
                          "Note": noteController.text,
                        }).then((value) {
                          isLoading = false;
                          Utils.toastMessage("Announcement added!");
                          Provider.of<AchievementPicker>(context, listen: false)
                              .nullPoster();
                          Navigator.of(context).pop();
                        });
                      } on FirebaseAuthException catch (e) {
                        Utils.toastMessage(e.message!);
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ExternalColors.lightgreen,
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    width: w,
                    height: h / 15,
                    child: isLoading == false
                        ? const Text("Submit")
                        : const CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

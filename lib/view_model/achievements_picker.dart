import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AchievementPicker with ChangeNotifier {
  ImagePicker imagePicke = ImagePicker();

  File? _img;
  File? get img => _img;

  File? _poster;
  File? get poster => _poster;
   List<String> _members = [];
  List<String> get members => _members;

  addMembers(String member) {
    _members.add(member);
    notifyListeners();
  }

  removeMember(String membername) {
    for (int i = 0; i < _members.length; i++) {
      if (members[i] == membername) {
        _members.removeAt(i);
      }
    }
    notifyListeners();
  }
  removerMembers(){
    _members=[];
    notifyListeners();
  }

  selectImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Pick image"),
          actions: [
            ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: () {
                  pickAchievement(ImageSource.camera);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  pickAchievement(ImageSource.gallery);
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  showBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Pick picture"),
          actions: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              onTap: () {
                pickPoster(ImageSource.camera);
                Navigator.pop(context);
              },
              title: const Text("Camera"),
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              onTap: () {
                pickPoster(ImageSource.gallery);
                Navigator.pop(context);
              },
              title: const Text("Gallery"),
            )
          ],
        );
      },
    );
  }

  removerImage(){
    _img=null;
    notifyListeners();
  }

  pickAchievement(ImageSource source) async {
    final pickedFile = await imagePicke.pickImage(source: source);
    if (pickedFile != null) {
      _img = File(pickedFile.path);
      
    }
    notifyListeners();
  }

  pickPoster(ImageSource source) async {
    final pickedPoster = await imagePicke.pickImage(source: source);
    if (pickedPoster != null) {
      _poster = File(pickedPoster.path);
      notifyListeners();
    }
  }

  nullPoster() {
    _poster = null;
    notifyListeners();
  }

  uploadPickedImg(String sport, String achievementid) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/$sport$achievementid}');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(
      File(img!.path),
    );
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    FirebaseFirestore.instance
        .collection("Sports Achievements")
        .doc(sport)
        .collection('achievements')
        .doc(achievementid)
        .update({"image": newUrl});
  }

  uploadPickedPoster(String announcementId) async {
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/announcement$announcementId');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(
      File(poster!.path),
    );
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementId)
        .update({
      "image": newUrl,
    });
  }


}

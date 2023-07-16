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

  pickimg(ImageSource source) async {
    final pickedfile = await imagePicke.pickImage(source: source);

    if (pickedfile != null) {
      _img = File(pickedfile.path);

      notifyListeners();
    }
  }

  pickPoster(ImageSource source) async {
    final pickedPoster = await imagePicke.pickImage(source: source);
    if (pickedPoster != null) {
      _poster = File(pickedPoster.path);
      notifyListeners();
    }
  }

  showBox(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
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
              },
              title: const Text("Camera"),
            ),
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              onTap: () {
                pickPoster(ImageSource.gallery);
              },
              title: const Text("Gallery"),
            )
          ],
        );
      },
    );
  }

  uploadPickedImg(String sport, String achievementid) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/$sport$achievementid}');
    firebase_storage.UploadTask uploadTask = storageRef.putFile(
      File(img!.path),
    );
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    FirebaseFirestore.instance.collection(sport).doc(achievementid).update({
      "image": newUrl,
    });
  }
  uploadPickedPoster(String announcementId) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/announcement$announcementId');
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

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/session_controller.dart';

class ProfileCrontroller extends ChangeNotifier {

  // ignore: deprecated_member_use
  final databaseReference = FirebaseDatabase.instance.reference();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static ImagePicker picker = ImagePicker();

  String? _profilepath;
  String? get profilepath => _profilepath;

  File? _profile;
  File? get profile => _profile;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  showD(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return  AlertDialog(
        title:const Text("Choose profile", style: TextStyle(color: Colors.black, fontSize: 20),),
        actions: [
          ListTile(onTap:(){
            pickeProfileImage(ImageSource.camera);
            Navigator.of(context).pop();

          },leading:const Icon(Icons.photo_camera),title: const Text("Camera"),),
          ListTile(onTap:(){
            pickeProfileImage(ImageSource.gallery);
             Navigator.of(context).pop();

          },leading:const Icon(Icons.photo),title: const Text("Gallery"),),
        ],
      );
    },);
  }


  Future pickeProfileImage(ImageSource source) async {
    final selectedfile = await picker.pickImage(source: source);
    if (selectedfile != null) {
        _profile=File(selectedfile.path);
        uploadProfileImage();
    }
    notifyListeners();
  }


  void uploadProfileImage() async {
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/ProfileImage${SessionController().uid!}');
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(profile!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    final user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .update({
          'profile': newUrl,
        })
        .onError((error, stackTrace) => Utils.toastMessage(error.toString()));
    ref
        .child(SessionController().uid.toString())
        .update({'profileImage': newUrl.toString()}).then((value) {

      // _profileimage = null;
      _profile = null;
      Utils.toastMessage('Profile Updated');
    }).onError((error, stackTrace) {
      setLoading(true);
      Utils.toastMessage(error.toString());
    });
  }

  
}
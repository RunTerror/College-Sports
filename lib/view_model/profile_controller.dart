import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/session_controller.dart';

class ProfileCrontroller extends ChangeNotifier {
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
        // backgroundColor: Colors.amber,
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

  // Future<void> replaceFile() async {
  //   final directory = await Directory.systemTemp.create();
  //   final filePath = '${directory.path}/cover.jpg';
  //   final file = File(filePath);
  //   if (await file.exists()) {
  //     await file.delete();
  //   }
  //   await getCoverImage();
  // }

  // Future<void> replaceProfile() async {
  //   final directory = await Directory.systemTemp.create();
  //   final filepath = '${directory.path}/profile.jpg';
  //   final file = File(filepath);
  //   if (await file.exists()) {
  //     print('exist replace profile' );
  //     await file.delete();
  //     await getProfileImage();
  //   }
  // }

  // Future<void> delteFolder()async{
  //   final directory=await Directory.systemTemp.create();
  //   final filepath='${directory.path}/profile.jpg';
  //   final coverpath='${directory.path}/cover.jpg';
  //   final file=File(filepath);
  //   final coverfile=File(coverpath);
  //   if(await file.exists()){
  //     await file.delete();
  //     notifyListeners();
  //   }
  //   if(await coverfile.exists()){
  //     await coverfile.delete();
  //     notifyListeners();
  //   }
  //   if(await file.exists()){
  //     print("Yes");
  //   }
  //   _cover==null;
  //   _profile==null;
  //   notifyListeners();


  // }

  Future pickeProfileImage(ImageSource source) async {
    final selectedfile = await picker.pickImage(source: source);
    if (selectedfile != null) {
        _profile=File(selectedfile.path);
        uploadProfileImage();
    }
    notifyListeners();
  }

  // void uploadCoverImage() async {
  //   setLoading(true);
  //   firebase_storage.Reference storageRef = firebase_storage
  //       .FirebaseStorage.instance
  //       .ref('/CoverImage${SessionController().uid!}');
  //   firebase_storage.UploadTask uploadTask =
  //       storageRef.putFile(File(cover!.path),);
  //   await Future.value(uploadTask);
  //   final newUrl = await storageRef.getDownloadURL();
  //   final user = FirebaseAuth.instance.currentUser!;
  //   final userData = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user.uid)
  //       .get();
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user.uid)
  //       .set({
  //         'email': userData.data()!['email'],
  //         'name': userData.data()!['name'],
  //         'profile': newUrl,
  //         'cover': userData.data()!['cover']
  //       })
  //       .onError((error, stackTrace) => Utils.toastMessage(error.toString()));
  // }

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

  // // Future<void> getCoverImage() async {
  // //   await FirebaseFirestore.instance
  // //       .collection('Users')
  // //       .doc(FirebaseAuth.instance.currentUser!.uid)
  // //       .get()
  // //       .then((value) async {
  // //     if (value['cover'] != "") {
  // //       final response = await http.get(Uri.parse(value['cover']));
  // //       final directory = await Directory.systemTemp.create();
  // //       final filePath = '${directory.path}/cover.jpg';
  // //       final file = File(filePath);
  // //       var ans = file.exists();
  // //       await file.writeAsBytes(response.bodyBytes);
  // //       print(ans);
  // //       _cover = file;
  // //       print('image downloaded to ${file.path}');
  // //       notifyListeners();
  // //       print("not empty");
  // //     } else {}
  // //   });
  // // }

  // // Future<void> getProfileImage() async {
  // //   FirebaseFirestore.instance
  // //       .collection('Users')
  // //       .doc(FirebaseAuth.instance.currentUser!.uid)
  // //       .get()
  // //       .then((value) async {
  // //     if (value['profile'] != "") {
  // //       final response = await http.get(Uri.parse(value['profile']));
  // //       final directory = await Directory.systemTemp.create();
  // //       final filepath = '${directory.path}/profile.jpg';
  // //       final file = File(filepath);
  // //       await file.writeAsBytes(response.bodyBytes);
  // //       _profile = file;
  // //       notifyListeners();
  // //     }
  // //   });
  // // }

  // // Future<void> checkCover() async {
  // //   final directory = await Directory.systemTemp.create();
  // //   final filepath = '${directory.path}/cover.jpg';
  // //   final file = File(filepath);
  // //   if (await file.exists()) {
  // //     print(file.path);
  // //     print("exist in storage");
  // //     _cover = file;
  // //     notifyListeners();
  // //   } else {
  // //     await getCoverImage();
  // //   }
  // // // }

  // // Future<void> checkProfile() async {
  //   final directory = await Directory.systemTemp.create();
  //   final filepath = '${directory.path}/profile.jpg';
  //   final file = File(filepath);
  //   if (await file.exists()) {
  //     print(file.path);
  //     _profile = file;
  //     notifyListeners();
  //   } else {
  //     getProfileImage();
  //   }
  // }
// }
}


import 'package:flutter/material.dart';

class WinningMembers with ChangeNotifier{

  List<Map<String, dynamic>> _members=[];
  List<Map<String, dynamic>> get members=> _members;

  addMembers(Map<String, dynamic> member){
    _members.add(member);
    notifyListeners();

  }
  
}
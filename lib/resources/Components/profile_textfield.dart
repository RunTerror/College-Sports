import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final int? maxLine;
  TextEditingController namecontroller;
  final String hintText;
  final IconData iconData;
   ProfileField({super.key,required this.namecontroller,required this.hintText,required this.iconData,this.maxLine=1});

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return Container(
            decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
            width: w/1.1,
             child: TextField(
              maxLines: maxLine,
              controller: namecontroller,
              decoration:InputDecoration(
                hintText: hintText,
                labelText: hintText,
                prefixIcon:Icon(iconData),
                border: const OutlineInputBorder()
              ),
             ),
           );
  }
}
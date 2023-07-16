import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

class ProfileContainer extends StatelessWidget {
  final IconData iconData;
  final String text;
  final function;
  const ProfileContainer({super.key,required this.function, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: function,
      child: Container(
        padding:const EdgeInsets.only(top: 5,bottom: 5),
        height: h / 8,
        width: h / 10,
        decoration: BoxDecoration(
            color: ExternalColors.offwhite,
            borderRadius: const BorderRadius.all(Radius.circular(20)),),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Icon(iconData, size: 30,),
              Center(child: Text(text))
            ],),
      ),
    );
  }
}

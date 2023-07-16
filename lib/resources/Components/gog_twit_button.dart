import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';


class GoogleButton extends StatelessWidget {
  final String image;
  final String text;
  const GoogleButton({super.key,required this.image,required this.text});

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: w/2.5,
      height: h/13,
      decoration: BoxDecoration(border: Border.all(width: 1, color: ExternalColors.lightgrey,), borderRadius:const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: h/30, child: Image(image: AssetImage(image), fit: BoxFit.cover,)),
        const SizedBox(width: 10,),
        Text(text)
      ],),
    );
  }
}
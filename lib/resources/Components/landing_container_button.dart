import 'package:flutter/material.dart';

class LandingButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback function;
  const LandingButton({super.key,required this.icon,required this.text,required this.function});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(color: theme.colorScheme.secondary, borderRadius:const BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        width: w/1.2,
        height: h/15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(text, style:const TextStyle(fontWeight: FontWeight.bold),),
        ],),
      ),
    );
  }
}
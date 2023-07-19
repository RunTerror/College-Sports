import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  const AuthButton({
    super.key,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: function,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ExternalColors.lightgreen,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          width: w / 1.1,
          height: 60,
          child: Text(text),
        ));
  }
}

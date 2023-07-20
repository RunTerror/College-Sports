import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  bool loading;
  final VoidCallback function;
  final String text;
  AuthButton({
    required this.loading,
    super.key,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.width;
    return InkWell(
        onTap: function,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ExternalColors.lightgreen,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          width: w / 1.1,
          height: h/8,
          child:loading==true?const CircularProgressIndicator(): Text(text),
        ));
  }
}

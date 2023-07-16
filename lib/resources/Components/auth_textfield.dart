import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String hintText;
  final iconClickEvent;
  final IconData prefixIcon;
  final String value;

  const AuthTextField({super.key,required this.controller,required this.hintText,required this.iconClickEvent,required this.keyboardType,required this.prefixIcon,required this.obscureText,required this.value});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.of(context).size.width;
    return  SizedBox(
      width: w/1.1,
      child: TextField(
        onChanged: (value) {
          value=value;
        },
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration:InputDecoration(prefixIcon: Icon(widget.prefixIcon),hintText: widget.hintText, labelText: widget.hintText,border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
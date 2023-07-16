import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  bool obscureText;
  final String value;
  AuthPasswordField(
      {super.key,
      required this.value,
      required this.controller,
      required this.icon,
      required this.text,
      required this.obscureText});

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.1,
      child: TextField(
        onChanged: (value) {
          value = value;
        },
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            labelText: widget.text,
            hintText: widget.text,
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: widget.obscureText
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}

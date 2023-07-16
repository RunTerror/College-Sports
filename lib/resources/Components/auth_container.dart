import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final double height;
  final double width;
  const AuthContainer({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [],
      ),
    );
  }
}
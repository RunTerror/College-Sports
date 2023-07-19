import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

class Register extends StatelessWidget {
  final VoidCallback function;
  const Register({super.key,required this.function});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 5,),
                        InkWell(onTap: function,child: Text("Register", style: TextStyle(color: ExternalColors.lightgreen, fontWeight: FontWeight.bold),))
                      ],
                    ),
                  );
  }
}
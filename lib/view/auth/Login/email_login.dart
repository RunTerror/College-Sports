import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/resources/Components/auth_button.dart';
import 'package:sports_application/resources/Components/auth_password_field.dart';
import 'package:sports_application/resources/Components/auth_textField.dart';
import 'package:sports_application/resources/Components/register.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/utils/utils.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passowrdcontroller = TextEditingController();
  String email = '';
  String password = '';
  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(() {
      setState(() {
        email = emailcontroller.text;
      });
    });
    passowrdcontroller.addListener(() {
      setState(() {
        password = passowrdcontroller.text;
      });
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passowrdcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: h,
              color: ExternalColors.offwhite,
            ),
            Container(
              height: h / 3,
              color: ExternalColors.darkblue,
            ),
            Positioned(
                left: 20,
                top: h / 3 - h / 8,
                child: const Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                )),
            Positioned(
                top: h / 3 + 30,
                left: (w - w / 1.1) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthTextField(
                      value: email,
                      obscureText: false,
                      controller: emailcontroller,
                      hintText: "Email",
                      iconClickEvent: () {},
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthPasswordField(
                        value: password,
                        controller: passowrdcontroller,
                        icon: Icons.lock_outline,
                        text: "Password",
                        obscureText: false),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: w / 1.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: ExternalColors.lightgreen,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    AuthButton(
                        function: () async {
                          var copy = emailcontroller.text;
                          if (emailcontroller.text.isEmpty) {
                            Utils.flushbarErrorMessage(
                                "Please enter your college email id", context);
                          }
                          //  else if (copy.substring(
                          //         emailcontroller.text.length - 17,
                          //         emailcontroller.text.length) !=
                          //     "@ietlucknow.ac.in") {
                          //   Utils.flushbarErrorMessage(
                          //       "Please correct your college email id",
                          //       context);
                          // } 
                          else {
                            if (passowrdcontroller.text.length < 6 ||
                                passowrdcontroller.text.isEmpty) {
                              Utils.flushbarErrorMessage(
                                  "Please enter atleast 6 digit password",
                                  context);
                            } else {
                              try {
                                await context
                                    .read<FirebaseAuthMethods>()
                                    .loginInWithEmailAndPassword(
                                        emailcontroller.text.trim().toString(),
                                        passowrdcontroller.text
                                            .trim()
                                            .toString(),
                                        context);
                                Navigator.pop(context);
                              } on FirebaseException catch (e) {
                                Utils.snackBar(e.message!, context);
                              }
                            }
                          }
                        },
                        text: "Login"),
                  ],
                )),
            Positioned(
                bottom: h / 30,
                child: Register(function: () {
                  Navigator.pushReplacementNamed(context, RouteNames.register);
                }))
          ],
        ),
      ),
    );
  }
}

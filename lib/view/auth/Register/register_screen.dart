import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/resources/Components/auth_button.dart';
import 'package:sports_application/resources/Components/auth_password_field.dart';
import 'package:sports_application/resources/Components/auth_textfield.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passowrdcontroller = TextEditingController();

  String name = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
    });
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
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailcontroller.dispose();
    passowrdcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: h,
              color: theme.scaffoldBackgroundColor,
            ),
            Container(
              height: h / 3,
              color: theme.primaryColor,
            ),
            Positioned(
              left: 25,
              top: h / 3 - h / 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "create your account",
                    style: theme.textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            Positioned(
              top: h / 3 + 30,
              left: (w - w / 1.1) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthTextField(
                      value: name,
                      controller: nameController,
                      hintText: "Full Name",
                      iconClickEvent: () {},
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.person,
                      obscureText: false),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                      value: email,
                      controller: emailcontroller,
                      hintText: "Email",
                      iconClickEvent: () {},
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      obscureText: false),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthPasswordField(
                    value: password,
                    controller: passowrdcontroller,
                    icon: Icons.lock_outline,
                    text: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                      function: () async {
                        var copy = emailcontroller.text;
                        if (nameController.text.isEmpty) {
                          Utils.flushbarErrorMessage(
                              "Please enter your full name", context);
                        } else if (emailcontroller.text.isEmpty) {
                          Utils.flushbarErrorMessage(
                              "Please enter your college email id", context);
                        }
                        else if (passowrdcontroller.text.length < 6 ||
                            passowrdcontroller.text.isEmpty) {
                          Utils.flushbarErrorMessage(
                              "Please enter at least 6 digit password",
                              context);
                        } else {
                          try {
                            context
                                .read<FirebaseAuthMethods>()
                                .signUpWithEmailAndPassword(
                                    emailcontroller.text.trim().toString(),
                                    passowrdcontroller.text.trim().toString(),
                                    nameController.text.trim().toString(),
                                    context);
                            Navigator.pop(context);
                            Utils.toastMessage(
                                "Verification link has been send to your email");
                          } on FirebaseAuthException catch (e) {
                            Utils.toastMessage(e.message!);
                          }
                        }
                      },
                      text: "Sign Up")
                ],
              ),
            ),
            Positioned(
                bottom: h / 30,
                child: Container(
                  width: w,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an accont?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.emaillogin);
                          },
                          child: Text(
                            "Sign In",
                            selectionColor: theme.colorScheme.secondary,
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

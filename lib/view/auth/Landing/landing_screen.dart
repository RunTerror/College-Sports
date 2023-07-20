import 'package:flutter/material.dart';
import 'package:sports_application/resources/Components/gog_twit_button.dart';
import 'package:sports_application/resources/Components/landing_container_button.dart';
import 'package:sports_application/resources/Components/register.dart';
import 'package:sports_application/utils/Routes/route_names.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: h,
                  width: w,
                  color: theme.scaffoldBackgroundColor,
                ),
                Container(
                  height: h / 2,
                  width: w,
                  color: theme.primaryColor,
                ),
                Positioned(
                  left: (w - w / 1.2) / 2,
                  top: h / 2 + 20,
                  child: LandingButton(
                      icon: Icons.mail_rounded,
                      text: "Continue with email",
                      function: () {
                        Navigator.pushNamed(context, RouteNames.emaillogin);
                      }),
                ),
                Positioned(
                    top: h/2+ 100,
                    child: Register(function: (){
                      Navigator.pushNamed(context, RouteNames.register);
                    }))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

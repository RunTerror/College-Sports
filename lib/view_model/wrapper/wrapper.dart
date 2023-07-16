import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/view/auth/Landing/landing_screen.dart';
import 'package:sports_application/view/auth/verification/verification.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthMethods>(context);
    return StreamBuilder<User?>(
      stream: authService.authState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.hasData) {
          return const VerificationScreen();
        } else {
          return const LandingScreen();
        }
      },
    );
  }
}

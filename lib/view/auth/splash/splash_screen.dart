import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sports_application/utils/Routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loader() {
    var time = const Duration(seconds: 3);
    return Timer(time, () {
      Navigator.pop(context);
      Navigator.pushNamed(context, RouteNames.wrapper);
    });
  }

  @override
  void initState() {
    loader();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: const Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}

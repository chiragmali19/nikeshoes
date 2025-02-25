import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nikeshoes/screens/StartUpScreens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAD961),
              Color(0xFFF76B1C),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}

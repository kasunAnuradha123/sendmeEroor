import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(
            context,MaterialPageRoute(
            builder: (_)=> WelcomeScreen(),
        ), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("sendMe",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
        ),
       ),
      )
    );
  }
}


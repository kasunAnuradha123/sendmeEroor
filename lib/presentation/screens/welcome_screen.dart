import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sendme/presentation/screens/registration_screen.dart';
import 'package:sendme/presentation/widgets/theme/style.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.only(top: 35,left: 25,bottom: 5,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Welcome to sendMe",
              style: TextStyle(
                fontSize: 30,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 260,
              width: 260,
              child: Image.asset("assets/wlc.gif"),
            ),
            Column(
              children: <Widget>[
                const Text(
                  "Let's get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
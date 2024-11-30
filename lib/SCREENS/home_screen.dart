import 'package:e_learning/COMPNENTS/common_button.dart';
import 'package:e_learning/SCREENS/LOGIN_SIGNUP_SCREENS/login.dart';
import 'package:e_learning/Services/authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SUccssefully Login",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            CommonButton(
              text: "Log Out",
              onTap: () async {
                await AuthServices().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Login(),

                    // i take random data in this .
                    //ibrahim if you want to remove such comment it.....
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

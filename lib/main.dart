import 'package:e_learning/SCREENS/home_screen.dart';
import 'package:e_learning/SCREENS/slider_page.dart';
import 'package:e_learning/SCREENS/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

      //this code is for user when it login once at once device until it logout.
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return HomeScreen();
      //     } else {
      //       return Login();
      //     }
      //   },
      // ),
    );
  }
}

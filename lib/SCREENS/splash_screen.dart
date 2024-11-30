import 'package:e_learning/SCREENS/LOGIN_SIGNUP_SCREENS/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Set default system UI mode (status bar and navigation bar visible)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    // Delay for 2 seconds before navigating
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // No need to reset UI mode here, as we already use the default mode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.lightBlue.shade500],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Align content vertically at the center
          children: [
            Image.asset("tools/images/logo.png"),
            Text(
              "Welcome to E_Learning",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.indigo.shade700, Colors.orange.shade200],

                    // Blue to Green gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 4.0,
                    color: Colors.black
                        .withOpacity(0.5), // Soft shadow for readability
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

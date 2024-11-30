import 'package:e_learning/COMPNENTS/common_button.dart';
import 'package:e_learning/COMPNENTS/common_textfield.dart';
import 'package:e_learning/COMPNENTS/snack_bar.dart';
import 'package:e_learning/SCREENS/LOGIN_SIGNUP_SCREENS/login.dart';
import 'package:e_learning/SCREENS/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/Services/authentication.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //controller to controll text in textfield
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  bool isloading = false;

  void despose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

//for signup screen to store data in firebase
  void signUpUser() async {
    setState(() {
      isloading = true;
    });

    String res = await AuthServices().signUpUser(
      email: emailcontroller.text,
      password: passwordcontroller.text,
      name: namecontroller.text,
    );

    setState(() {
      isloading = false;
    });

    if (res == "success") {
      debugPrint("Signup successful, navigating to Home screen...");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      debugPrint("Signup failed: $res");
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //main background color
      backgroundColor: Color(0xFFE0E0E0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7,
                child: Image.asset("tools/images/logo.png"),
              ),
              //text design for main text below pic
              Text(
                "Welcome to E_Learning",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  height: 1.5,
                  letterSpacing: 1.2,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Colors.blue.shade700, Colors.teal.shade400],
                      // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0), // Slight offset for depth
                      blurRadius: 5.0,
                      color: Colors.black
                          .withOpacity(0.3), // Subtle shadow for legibility
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              //all textfield taken from commontextfield
              CommonTextfield(
                textEditingController: namecontroller,
                hintText: "Enter your name",
                icon: Icons.person,
              ),
              CommonTextfield(
                textEditingController: emailcontroller,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              CommonTextfield(
                textEditingController: passwordcontroller,
                hintText: "Enter your password",
                ispass: true,
                icon: Icons.lock,
              ),
              //circular progress indicator when to press on signup button
              isloading
                  ? const CircularProgressIndicator() // Show loader if signing up
                  : CommonButton(
                      text: "Sign Up",
                      onTap: signUpUser,
                    ),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  //i use this for ontap fuction
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Login(), //move to login screen when tap
                        ),
                      );
                    },
                    child: const Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_learning/COMPNENTS/common_button.dart';
import 'package:e_learning/COMPNENTS/common_textfield.dart';
import 'package:e_learning/COMPNENTS/snack_bar.dart';
import 'package:e_learning/SCREENS/LOGIN_SIGNUP_SCREENS/signup.dart';
import 'package:e_learning/SCREENS/home_screen.dart';
import 'package:e_learning/SCREENS/slider_page.dart';
import 'package:e_learning/Services/authentication.dart';
import 'package:e_learning/Services/forget_password.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //controller to control text in a textfield
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLoading = false;
//for login 
  void loginUser() async {
    //condition
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar(context, "Please fill in all the fields.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String res = await AuthServices().loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (res == "Success") {
        // Navigate to the Home screen
        debugPrint("Signup successful, navigating to Home screen...");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            //changes by awais
            builder: (context) => const SliderPage(),
          ),
        );
      } else {
        // Display the error message
        showSnackBar(context, res);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "An unexpected error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: SafeArea(
        child: SingleChildScrollView(
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
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  height: 1.5,
                  letterSpacing: 1.2,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [Colors.blue.shade700, Colors.teal.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CommonTextfield(
                textEditingController: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              CommonTextfield(
                textEditingController: passwordController,
                hintText: "Enter your password",
                ispass: true,
                icon: Icons.lock,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 10,
                ),
                // child: Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Forgot Password?",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 17,
                //       color: Colors.blue,
                //     ),
                //   ),
                // ),
              ),
              //circular progress indicator when press on button login
              isLoading
                  ? const CircularProgressIndicator()
                  : CommonButton(
                      text: "Log In",
                      onTap: loginUser,
                    ),
              //forget password
              const ForgetPassword(),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signup(),
                        ),
                      );
                    },
                    child: const Text(
                      " SignUp",
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

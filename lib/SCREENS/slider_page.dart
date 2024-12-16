import 'package:e_learning/SCREENS/LOGIN_SIGNUP_SCREENS/login.dart';
import 'package:e_learning/SCREENS/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  PageController _controller = PageController();
  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE0E0E0),
        body: Column(
          children: [
            Expanded(
                child: PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  islast = index == 2;
                });
              },
              children: [
                buildIntroPage(
                  title: "Welcome to LearnEase",
                  description:
                      "Unlock the power of knowledge with our easy-to-use platform. Start your journey towards smarter learning today",
                ),
                buildIntroPage(
                  title: "Engage, Explore, Exce",
                  description:
                      "Discover interactive courses, gain new skills, and explore content tailored to your learning goals.",
                ),
                buildIntroPage(
                  title: "Learn Anywhere",
                  description:
                      "Learn at your own pace, anytime, anywhere. Let's make learning an enjoyable experience together!",
                ),
              ],
            )),
            SizedBox(
              height: 15,
            ),
            Center(
                child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotWidth: 7,
                dotHeight: 7,
                dotColor: Colors.black12,
              ),
            )),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {
                    islast
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()))
                        : _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                  },
                  child: islast
                      ? Text(
                          "Done",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      : Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class buildIntroPage extends StatelessWidget {
  String title;
  String description;
  buildIntroPage({super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Image.asset('tools/images/logo.png'),
        )),
        SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 10.3,
        ),
      ],
    );
  }
}

// this the home screen data for temp

// Text(
//                 "SUccssefully Login",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               CommonButton(
//                 text: "Log Out",
//                 onTap: () async {
//                   await AuthServices().signOut();
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => Login(),

//                       // i take random data in this .
//                       //ibrahim if you want to remove such comment it.....
//                     ),
//                   );
//                 },
//               ),

import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final IconData icon;

  const CommonTextfield({
    super.key,
    required this.textEditingController,
    this.ispass = false,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      //common textfield for signup and login
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: false,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          prefixIcon: Icon(
            icon,
            color: Colors.black45,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFFFFFFFF),
          // fillColor: const Color(0xFFedf0f8),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}

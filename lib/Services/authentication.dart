import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // Register user in Firebase Authentication
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user data to Cloud Firestore
        await _firestore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });

        res = "success"; // Update response on successful operation
      }
    } catch (e) {
      print("Error during sign-up: $e");
      res = e.toString(); // Pass the actual error message
    }
    return res;
  }

  //for login screen
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //login user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Success";
      } else {
        res = "Please enter all the field";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  //for LogOut
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

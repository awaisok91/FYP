import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      //get user data from firestore
      final doc = await _firestore.collection("users").doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    });
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    final UserCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await UserCredential.user!.updateDisplayName(fullName);
    final User = UserModel(
      uid: UserCredential.user!.uid,
      email: email,
      fullName: fullName,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      role: role,
    );
    //save user data to firestore
    await _firestore
        .collection("users")
        .doc(UserCredential.user!.uid)
        .set(User.toFirestore());
    try {
      await _firestore
          .collection("users")
          .doc(User.uid)
          .set(User.toFirestore());
      return User;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  //for sign in with email and password
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //get user data from firestore
      final doc = await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      if (!doc.exists) {
        throw Exception("User data not found");
      }
      final user = UserModel.fromFirestore(doc);
      //update last login time
      await _firestore
          .collection("users")
          .doc(user.uid)
          .update({"lastLoginAt": Timestamp.now()});
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? photoUrl,
    String? phoneNumber,
    String? bio,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception("User not found");
      final updates = <String, dynamic>{};
      if (fullName != null) {
        await user.updateDisplayName(fullName);
        updates["fullName"] = fullName;
      }
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
        updates["photoUrl"] = photoUrl;
      }
      if (phoneNumber != null) updates["phoneNumber"] = phoneNumber;
      if (bio != null) updates["bio"] = bio;
      //update firestore if there is changes
      if (updates.isNotEmpty) {
        await _firestore.collection("users").doc(user.uid).update(updates);
      }
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case "weak-password":
        return "The password provided is too weak.";
      case "email-already-in-use":
        return "Account already exsist with this email";
      case "user-not-found":
        return "No account found this email";
      case "wrong-password":
        return "Incorrect password";
      case "invalid-email":
        return "Please enter a valid email address";
      case "user-disabled":
        return "This account has been disabled";
      case "operation-not-allowed":
        return "Email and password sign-in is not enabled";
      case "too-many-requests":
        return "Too many attempts. Please try again later";
      case "network-request-failed":
        return "Network error. Please check your connection";
      case "invalid-credential":
        return "Invalid login credential";
      default:
        return e.message ?? "An undefined Error happened.";
    }
  }
}

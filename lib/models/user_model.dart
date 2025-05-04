import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? fullName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final UserRole role;
  UserModel({
    required this.uid,
    required this.email,
    this.fullName,
    this.photoUrl,
    required this.createdAt,
    required this.lastLoginAt,
    required this.role,
  });
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      fullName: data["fullName"] ?? "",
      photoUrl: data["photoUrl"] ?? "",
      email: data["email"] ?? "",
      createdAt: (data["createdAt"] as Timestamp).toDate(),
      lastLoginAt: (data["lastLoginAt"] as Timestamp).toDate(),
      role: UserRole.values.firstWhere(
        (e) => e.name == data["role"],
        orElse: () => UserRole.student,
      ),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "fullName": fullName,
      "photoUrl": photoUrl,
      "email": email,
      "createdAt": Timestamp.fromDate(createdAt),
      "lastLoginAt": Timestamp.fromDate(lastLoginAt),
      "role": role.name,
    };
  }
}

enum UserRole {
  student,
  teacher,
  // admin,
}

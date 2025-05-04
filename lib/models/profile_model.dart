import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String fullName;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final profileStatus status;
  final String? bio;
  const ProfileModel({
    required this.fullName,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    required this.status,
    this.bio,
  });
  ProfileModel copyWith({
    String? fullName,
    String? email,
    String? photoUrl,
    String? phoneNumber,
    profileStatus? status,
    String? bio,
  }) {
    return ProfileModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        email,
        phoneNumber ?? '',
        photoUrl ?? '',
        bio ?? '',
        status,
      ];
}

class profileStatus extends Equatable {
  final int courseCount;
  final int hoursSpent;
  final double successRate;
  const profileStatus({
    required this.courseCount,
    required this.hoursSpent,
    required this.successRate,
  });
  @override
  List<Object?> get props => [
    courseCount,
    hoursSpent,
    successRate,
  ];
}

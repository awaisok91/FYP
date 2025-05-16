import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileRequested extends ProfileEvent {
  final String? fullName;
  final String? phoneNumber;
  final String? bio;
  final String? photoUrl;
  const UpdateProfileRequested({
    this.fullName,
    this.phoneNumber,
    this.bio,
    this.photoUrl,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [fullName, phoneNumber, bio, photoUrl];
}

class UpdateProfilePhotRequested extends ProfileEvent {
  final String photoPath;
  const UpdateProfilePhotRequested(this.photoPath);
  @override
  // TODO: implement props
  List<Object?> get props => [photoPath];
}

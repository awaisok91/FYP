import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_state.dart';
import 'package:e_learning/bloc/profile/profile_event.dart';
import 'package:e_learning/bloc/profile/profile_state.dart';
import 'package:e_learning/models/profile_model.dart';
import 'package:e_learning/repositories/auth_repository.dart';
import 'package:e_learning/services/cloudinary_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final AuthRepository _authRepository;
  late final StreamSubscription<AuthState> _authSubscription;
  final CloudinaryService _cloudinaryService;
  ProfileBloc({
    required AuthBloc authBloc,
    AuthRepository? authRepository,
    CloudinaryService? cloudinaryService,
  })  : _authBloc = authBloc,
        _authRepository = authRepository ?? AuthRepository(),
        _cloudinaryService = cloudinaryService ?? CloudinaryService(),
        super(const ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
    on<UpdateProfilePhotRequested>(_onUpdateProfilePhotoRequested);
    //load profile when aut state changes
    _authSubscription = authBloc.stream.listen((AuthState) {
      if (AuthState.userModel != null) {
        add(LoadProfile());
      }
    });
    //inital load when user is already login
    if (_authBloc.state.userModel != null) {
      add(LoadProfile());
    }
  }
  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final UserModel = _authBloc.state.userModel;

      if (UserModel != null) {
        final profile = ProfileModel(
          fullName: UserModel.fullName ?? "",
          email: UserModel.email,
          phoneNumber: UserModel.phoneNumber,
          bio: UserModel.bio,
          photoUrl: UserModel.photoUrl,
          status: const profileStatus(
            courseCount: 0,
            hoursSpent: 0,
            successRate: 0,
          ),
        );
        emit(state.copyWith(isLoading: false, profile: profile));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: true, error: e.toString()));
    }
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    //firebase update
    try {
      emit(state.copyWith(isLoading: true));
      //call repository method directly through authBloc
      // final userModel = _authBloc.state.userModel;

      await _authRepository.updateProfile(
        fullName: event.fullName,
        photoUrl: event.photoUrl,
        phoneNumber: event.phoneNumber,
        bio: event.bio,
      );
      if (state.profile != null) {
        final updatedProfile = state.profile!.copyWith(
          fullName: event.fullName,
          photoUrl: event.photoUrl,
          phoneNumber: event.phoneNumber,
          bio: event.bio,
        );
        emit(state.copyWith(isLoading: false, profile: updatedProfile));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onUpdateProfilePhotoRequested(
    UpdateProfilePhotRequested event,
    Emitter<ProfileState> emit,
  ) async {
    //will implement firebase storage later
    try {
      emit(state.copyWith(isLoading: true));
      //upload to cloudinary services
      final photoUrl = await _cloudinaryService.uploadImage(
          event.photoPath, "profile_pictures");
      //update profile with new photo url
      add(UpdateProfileRequested(
        photoUrl: photoUrl,
      ));
      emit(state.copyWith(isPhotoUploading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isPhotoUploading: false));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _authSubscription.cancel();
    return super.close();
  }
}

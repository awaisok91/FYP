// import 'dart:async';

// import 'package:e_learning/bloc/auth/auth_event.dart';
// import 'package:e_learning/bloc/auth/auth_state.dart';
// import 'package:e_learning/repositories/auth_repository.dart';
// import 'package:e_learning/routes/app_routes.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository _authRepository;
//   StreamSubscription? _authStateSubscription;

//   //this is the AuthBloc class that extends the Bloc class from the flutter_bloc package
//   AuthBloc({AuthRepository? authRepository})
//       : _authRepository = authRepository ?? AuthRepository(),
//         super(const AuthState()) {
//     //this is the constructor of the AuthBloc class
//     _authStateSubscription = _authRepository.authStateChanges.listen(
//       (user) => add(AuthStateChanged(user)),
//     );
//     on<AuthStateChanged>(_onAuthStateChanged);
//     on<RegisterRequested>(_onRegisterRequested);
//     on<LoginRequested>(_onLoginRequested);
//     on<LogoutRequested>(_onLogoutRequested);
//     on<UpdateProfilerequested>(_onUpdateProfileRequested);
//     on<ForgetPasswordRequested>(_onForgetPasswordRequested);
//   }
//   Future<void> _onAuthStateChanged(
//     AuthStateChanged event,
//     Emitter<AuthState> emit,
//   ) async {
//     if (event.user != null) {
//       emit(state.copyWith(
//         userModel: event.user,
//         isLoading: false,
//         error: null,
//       ));
//     } else {
//       emit(const AuthState());
//     }
//   }

//   Future<void> _onRegisterRequested(
//     //this is the event handler for the RegisterRequested event
//     RegisterRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(
//         isLoading: true,
//         error: null,
//       )); //this updates the state with the loading state
//       final user = await _authRepository.signUp(
//         email: event.email,
//         password: event.password,
//         fullName: event.fullName,
//         role: event.role,
//       );
//       emit(state.copyWith(
//         isLoading: false,
//         userModel: user,
//         error: null,
//       ));
//     } catch (e) {
//       emit(state.copyWith(
//         error: e.toString(),
//         isLoading: false,
//         userModel: null,
//       ));
//       //this updates the state with the error message
//     }
//   }

//   Future<void> _onLoginRequested(
//     LoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(
//         isLoading: true,
//         error: null,
//       ));
//       await _authRepository.signIn(
//         email: event.email,
//         password: event.password,
//       ); //this updates the state with the loading state
//       emit(state.copyWith(isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), isLoading: false));
//     }
//   }

//   Future<void> _onLogoutRequested(
//     LogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(isLoading: true));
//       await _authRepository.signOut();
//       emit(const AuthState());
//       Get.offAllNamed(AppRoutes.login);
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), isLoading: false));
//     }
//   }

//   Future<void> _onUpdateProfileRequested(
//     UpdateProfilerequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(isLoading: true, error: null));
//       await _authRepository.updateProfile(
//         fullName: event.fullName,
//         photoUrl: event.photoUrl,
//       ); //this updates the state with the loading state
//       emit(state.copyWith(isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), isLoading: false));
//     }
//   }

//   Future<void> _onForgetPasswordRequested(
//     ForgetPasswordRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(isLoading: true, error: null));
//       await _authRepository.resetPassword(
//         event.email,
//       ); //this updates the state with the loading state
//       emit(state.copyWith(isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(error: e.toString(), isLoading: false));
//     }
//   }

//   @override
//   Future<void> close() {
//     // TODO: implement close
//     _authStateSubscription?.cancel();
//     return super.close();
//   }
// }
import 'dart:async';

import 'package:e_learning/bloc/auth/auth_event.dart';
import 'package:e_learning/bloc/auth/auth_state.dart';
import 'package:e_learning/repositories/auth_repository.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription? _authStateSubscription;

  AuthBloc({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const AuthState()) {
    _authStateSubscription = _authRepository.authStateChanges.listen(
      (user) => add(AuthStateChanged(user)),
    );

    on<AuthStateChanged>(_onAuthStateChanged);
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<UpdateProfilerequested>(_onUpdateProfileRequested);
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
  }

  Future<void> _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(state.copyWith(
        userModel: event.user,
        isLoading: false,
        error: null,
      ));
    } else {
      emit(const AuthState());
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      final user = await _authRepository.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        role: event.role,
      );

      emit(state.copyWith(
        isLoading: false,
        userModel: user,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
        userModel: null,
      ));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(
        isLoading: true,
        error: null,
      ));

      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      // No emit here; authStateChanges stream will trigger AuthStateChanged
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _authRepository.signOut();
      emit(const AuthState());
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfilerequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _authRepository.updateProfile(
        fullName: event.fullName,
        photoUrl: event.photoUrl,
        phoneNumber: event.phoneNumber,
        bio: event.bio,
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onForgetPasswordRequested(
    ForgetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _authRepository.resetPassword(event.email);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}

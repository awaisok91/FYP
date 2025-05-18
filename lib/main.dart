// import 'package:e_learning/bloc/auth/auth_bloc.dart';
// import 'package:e_learning/bloc/auth/auth_state.dart';
// import 'package:e_learning/bloc/font/font_bloc.dart';
// import 'package:e_learning/bloc/font/font_state.dart';
// import 'package:e_learning/bloc/profile/profile_bloc.dart';
// import 'package:e_learning/core/theme/app_theme.dart';
// import 'package:e_learning/routes/app_routes.dart';
// import 'package:e_learning/routes/routes_pages.dart';
// import 'package:e_learning/services/storage_services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// void main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await StorageServices.init(); // ✅ Required for using GetStorage
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<FontBloc>(
//           create: (context) => FontBloc(),
//         ),
//         BlocProvider<AuthBloc>(
//           create: (context) => AuthBloc(),
//         ),
//         // BlocProvider<ProfileBloc>(
//         //   create: (context) => ProfileBloc(),
//         // ),
//       ],
//       child: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state.error != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error!),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<FontBloc, FontState>(
//           builder: (context, fontsate) {
//             return GetMaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: "E_Learning_App",
//               theme: AppTheme.getLightTheme(fontsate),
//               themeMode: ThemeMode.light,
//               initialRoute: AppRoutes.splash,
//               onGenerateRoute: AppRoutes.onGenerateRoute,
//               getPages: AppPages.pages,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_state.dart';
import 'package:e_learning/bloc/course/course_bloc.dart';
import 'package:e_learning/bloc/font/font_bloc.dart';
import 'package:e_learning/bloc/font/font_state.dart';
import 'package:e_learning/bloc/profile/profile_bloc.dart';
import 'package:e_learning/core/theme/app_theme.dart';
import 'package:e_learning/repositories/courses_repository.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/routes/routes_pages.dart';
import 'package:e_learning/services/storage_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageServices.init(); // ✅ Ensure GetStorage is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FontBloc>(
          create: (context) => FontBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            // authRepository: AuthRepository(),
          ),
        ),
         BlocProvider<CourseBloc>(
          create: (context) => CourseBloc(
            authBloc: context.read<AuthBloc>(),
            coursesRepository: CoursesRepository(),
          ),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          }
        },
        child: BlocBuilder<FontBloc, FontState>(
          builder: (context, fontState) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "E_Learning_App",
              theme: AppTheme.getLightTheme(fontState),
              themeMode: ThemeMode.light,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              getPages: AppPages.pages,
            );
          },
        ),
      ),
    );
  }
}

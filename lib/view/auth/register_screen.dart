import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_event.dart';
import 'package:e_learning/bloc/auth/auth_state.dart';
import 'package:e_learning/core/utils/validators.dart';
import 'package:e_learning/models/user_model.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/widgets/common/custom_button.dart';
import 'package:e_learning/view/widgets/common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordContoller = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  UserRole? selectedRole;
  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordContoller.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state.userModel != null) {
          if (state.userModel!.role == UserRole.student) {}
          // Get.offAllNamed(AppRoutes.teacherHome);
          Get.offAllNamed(AppRoutes.main);

        } else {
          // Get.offAllNamed(AppRoutes.main);
          // Get.offAllNamed(AppRoutes.teacherHome);

        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "tools/images/logo.png",
                            scale: 7.0,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Start your learning journey",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Form(
                      key: _fromKey,
                      child: Column(
                        children: [
                          //textfield for full name
                          CustomTextfield(
                            label: "Full Name",
                            prefixIcon: Icons.person_outline,
                            controller: _fullNameController,
                            validate: FromValidator.validateFullName,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            label: "Email",
                            prefixIcon: Icons.email_outlined,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validate: FromValidator.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            label: "Password",
                            prefixIcon: Icons.lock_outline,
                            controller: _passwordContoller,
                            validate: FromValidator.validatePassword,
                            obsecureText: true,
                          ),
                          const SizedBox(height: 20),
                          CustomTextfield(
                            label: "Confirm Password",
                            prefixIcon: Icons.lock_outline,
                            controller: _confirmPasswordController,
                            obsecureText: true,
                            validate: (Value) =>
                                FromValidator.validateConfirmPassword(
                                    Value, _passwordContoller.text),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<UserRole>(
                      decoration: InputDecoration(
                        labelText: "Select Role",
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      value: selectedRole,
                      items: UserRole.values
                          .map((role) => DropdownMenuItem<UserRole>(
                                value: role,
                                child: Text(role.toString().split('.').last),
                              ))
                          .toList(),
                      onChanged: (UserRole? value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                    //button to register
                    const SizedBox(height: 20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: "Register",
                          onPressed: _handleRegister,
                          isLoading: state.isLoading,
                        );
                      },
                    ),
                    //login link
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.login),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_fromKey.currentState!.validate() && selectedRole != null) {
      //handle registeration logic
      context.read<AuthBloc>().add(
            RegisterRequested(
              email: _emailController.text,
              password: _passwordContoller.text,
              fullName: _fullNameController.text,
              role: selectedRole!,
            ),
          );
    } else if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a role"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

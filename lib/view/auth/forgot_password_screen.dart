import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_event.dart';
import 'package:e_learning/bloc/auth/auth_state.dart';
import 'package:e_learning/core/utils/validators.dart';

import 'package:e_learning/view/widgets/common/custom_button.dart';
import 'package:e_learning/view/widgets/common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  void _handleRestPassword() {
    if (_fromKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            ForgetPasswordRequested(email: _emailController.text),
          );
    }
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
        } else if (!state.isLoading && state.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password reset email send successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _fromKey,
                child: CustomTextfield(
                  label: "Email",
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validate: FromValidator.validateEmail,
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    text: "Rest Password",
                    onPressed: _handleRestPassword,
                    isLoading: state.isLoading,
                  );
                },
              ),
              // CustomButton(
              //   text: "Rest Password",
              //   onPressed: _handleRestPassword,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

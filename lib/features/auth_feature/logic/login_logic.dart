import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supplements_app/core/utils/app_snack_bars.dart';
import 'package:supplements_app/core/utils/validators.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_cubit.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_state.dart';

class LoginLogic {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginLogic({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  /// Handles login form submission with validation
  void handleLogin(BuildContext context) {
    // Check if form is valid
    if (formKey.currentState!.validate()) {
      // All fields are valid, proceed with Firebase authentication
      _performFirebaseLogin(context);
    } else {
      // Form is invalid, show error message
      _showValidationError(context);
    }
  }

  /// Performs Firebase authentication login
  void _performFirebaseLogin(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    authCubit.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  /// Shows validation error message
  void _showValidationError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBars.error('Please fill in all required fields correctly'),
    );
  }

  /// Validates email field
  String? validateEmail(String? value) {
    return Validators.validateEmail(value);
  }

  /// Validates password field
  String? validatePassword(String? value) {
    return Validators.validatePassword(value);
  }

  /// Navigates to register screen
  void navigateToRegister(BuildContext context) {
    context.pushReplacement('/register');
  }

  /// Handles authentication state changes
  void handleAuthStateChange(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      // Navigate to home screen on successful login
      context.push('/home');

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(AppSnackBars.success(state.message));
    } else if (state is AuthError) {
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(AppSnackBars.error(state.message));
    }
  }

  /// Disposes controllers
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

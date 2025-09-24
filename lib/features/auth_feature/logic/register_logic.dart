import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supplements_app/core/utils/app_snack_bars.dart';
import 'package:supplements_app/core/utils/validators.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_cubit.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_state.dart';

class RegisterLogic {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  RegisterLogic({
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  /// Handles register form submission with validation
  void handleRegister(BuildContext context) {
    // Check if form is valid
    if (formKey.currentState!.validate()) {
      // All fields are valid, proceed with Firebase registration
      _performFirebaseRegistration(context);
    } else {
      // Form is invalid, show error message
      _showValidationError(context);
    }
  }

  /// Performs Firebase authentication registration
  void _performFirebaseRegistration(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    authCubit.signUpWithEmailAndPassword(
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

  /// Validates full name field
  String? validateName(String? value) {
    return Validators.validateName(value);
  }

  /// Validates email field
  String? validateEmail(String? value) {
    return Validators.validateEmail(value);
  }

  /// Validates password field
  String? validatePassword(String? value) {
    return Validators.validatePassword(value);
  }

  /// Validates confirm password field
  String? validateConfirmPassword(String? value) {
    return Validators.validateConfirmPassword(value, passwordController.text);
  }

  /// Navigates to login screen
  void navigateToLogin(BuildContext context) {
    context.pushReplacement('/login');
  }

  /// Handles authentication state changes
  void handleAuthStateChange(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      // Navigate to home screen on successful registration
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

  /// Disposes all controllers
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }
}

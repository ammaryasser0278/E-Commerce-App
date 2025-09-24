import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/core/common_widgets/app_title.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_cubit.dart';
import 'package:supplements_app/features/auth_feature/logic/register_logic.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_state.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_button.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_text_button.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late final RegisterLogic _registerLogic;

  @override
  void initState() {
    super.initState();
    _registerLogic = RegisterLogic(
      formKey: _formKey,
      fullNameController: fullNameController,
      emailController: emailController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      phoneController: phoneController,
    );
  }

  @override
  void dispose() {
    _registerLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _registerLogic.handleAuthStateChange(context, state);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.09),
                Icon(Icons.fitness_center, size: 100, color: Colors.green),
                const SizedBox(height: 10),
                AppTitle(),
                const SizedBox(height: 30),
                CustomTextField(
                  label: 'Full Name',
                  icon: Icons.person,
                  controller: fullNameController,
                  validator: _registerLogic.validateName,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _registerLogic.validateEmail,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Password',
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                  validator: _registerLogic.validatePassword,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Confirm Password',
                  icon: Icons.lock_outline,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: _registerLogic.validateConfirmPassword,
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: "Register",
                      onPressed: state is AuthLoading
                          ? null
                          : () => _registerLogic.handleRegister(context),
                      isLoading: state is AuthLoading,
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomTextButton(
                  text: 'Already have an account? Login',
                  onPressed: () {
                    _registerLogic.navigateToLogin(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

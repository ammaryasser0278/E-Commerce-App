import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supplements_app/core/common_widgets/app_title.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_cubit.dart';
import 'package:supplements_app/features/auth_feature/logic/login_logic.dart';
import 'package:supplements_app/features/auth_feature/logic/auth_cubit/auth_state.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_button.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_text_button.dart';
import 'package:supplements_app/features/auth_feature/views/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final LoginLogic _loginLogic;

  @override
  void initState() {
    super.initState();
    _loginLogic = LoginLogic(
      formKey: _formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }

  @override
  void dispose() {
    _loginLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _loginLogic.handleAuthStateChange(context, state);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.16),
                Icon(Icons.fitness_center, size: 100, color: Colors.green),
                const SizedBox(height: 10),
                AppTitle(),
                const SizedBox(height: 30),
                CustomTextField(
                  label: 'Email',
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _loginLogic.validateEmail,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  obscureText: true,
                  validator: _loginLogic.validatePassword,
                ),
                const SizedBox(height: 25),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'Login',
                      onPressed: state is AuthLoading
                          ? null
                          : () => _loginLogic.handleLogin(context),
                      isLoading: state is AuthLoading,
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomTextButton(
                  text: 'You don\'t have an account? Sign Up',
                  onPressed: () {
                    _loginLogic.navigateToRegister(context);
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

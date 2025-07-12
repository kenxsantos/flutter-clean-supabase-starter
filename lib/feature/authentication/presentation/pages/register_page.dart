import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/core/validators/text_field_validation.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/header_container.dart';
import 'package:flutter_clean_supabase_starter/feature/authentication/presentation/widgets/oauth_container.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_button.dart';
import 'package:flutter_clean_supabase_starter/shared/components/custom_textfield.dart';
import 'package:flutter_clean_supabase_starter/shared/components/error_banner.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();

  void _signUp() {
    if (signUpFormKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      context.read<AuthBloc>().add(
        UserSignedUp(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is EmailVerificationRequired) {
              context.go('/verify-email/${state.email}');
            }
            if (state is AuthSuccess ||
                state is AuthEmailSuccess ||
                state is AuthFacebookSignInSuccess ||
                state is AuthGoogleSignInSuccess) {
              context.go('/auth-gate');
            }
          },
          builder: (context, state) {
            return Form(
              key: signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const HeaderContainer(
                    headerText: "Sign Up",
                    subText: "Just a few quick things to get started!",
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state is AuthError
                        ? ErrorBanner(
                            key: ValueKey(state.errorMsg),
                            message: state.errorMsg,
                          )
                        : const SizedBox.shrink(),
                  ),
                  CustomTextfield(
                    text: "Email",
                    validator: emailValidation,
                    controller: emailController,
                  ),
                  CustomTextfield(
                    text: "Password",
                    icon: Icons.visibility_off,
                    isPassword: true,
                    validator: emptyValidation,
                    controller: passwordController,
                  ),
                  CustomTextfield(
                    text: "Confirm Password",
                    icon: Icons.visibility_off,
                    isPassword: true,
                    validator: (value) {
                      return confirmPasswordValidation(
                        value,
                        passwordController,
                      );
                    },
                    controller: cPasswordController,
                  ),
                  CustomButton(text: "Sign Up", btnAction: _signUp),
                  GestureDetector(
                    onTap: () {
                      context.go("/login");
                      context.read<AuthBloc>().add(AuthReset());
                    },
                    child: Text(
                      "Don't have an account? Log In",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const OAuthContainer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
    super.dispose();
  }
}
